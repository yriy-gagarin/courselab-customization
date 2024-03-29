const path = require('path');

const TerserPlugin = require('terser-webpack-plugin');
const { ConcatSource } = require("webpack-sources");
const { GitRevisionPlugin } = require('git-revision-webpack-plugin');
const RemovePlugin = require('remove-files-webpack-plugin');

/**
 * @param {string} str string to wrap
 * @returns {string} wrapped string
 */
const wrapComment = str => {
  return `/**\n * ${str
    .replace(/\*\//g, "* /")
    .split("\n")
    .join("\n * ")
    .replace(/\s+\n/g, "\n")
    .trimEnd()}\n */`;
};

class AuxiliaryFileBannerPlugin {

  /**
   * @constructor
   * @param {{banner: string, file: string}} options
   */
  constructor(options) {
    this.options = options;
  }

  /**
   * Apply the plugin
   * @param {Compiler} compiler the compiler instance
   * @returns {void}
   */
  apply(compiler) {
    const {banner, file} = this.options;

    compiler.hooks.compilation.tap("AuxiliaryFileBannerPlugin", compilation => {
      compilation.hooks.processAssets.tap(
        {
          name: "AuxiliaryFileBannerPlugin",
          stage: 500 // Compilation.PROCESS_ASSETS_STAGE_DEV_TOOLING = 500;
        },
        () => {
          for (const chunk of compilation.chunks) {
            for (const chunkFile of chunk.auxiliaryFiles) {
              if (file!==chunkFile) {
                continue;
              }
              const comment = wrapComment(banner);
              compilation.updateAsset(file, old => new ConcatSource(comment, "\n", old));
            }
          }
        }
      );
    });
  }
}

const assetModuleFilename = './module.js';
const outputFilename = './module.build.js';

const commithashCommand = 'rev-parse --short HEAD';
const versionCommand = 'describe --tags --abbrev=0';
const gitRevisionPlugin = new GitRevisionPlugin({ commithashCommand, versionCommand });
const appVersion = JSON.stringify(gitRevisionPlugin.version());
const appGitBranch = JSON.stringify(gitRevisionPlugin.branch());
const appGitCommit = JSON.stringify(gitRevisionPlugin.commithash());

module.exports = {
  entry: './1/module.js',
  mode: 'production',
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        extractComments: false,
      }),
    ],
  },
  module: {
    rules: [
      {
        test: /module.js/,
        type: 'asset/resource',
      },
    ],
  },
  plugins: [
    new AuxiliaryFileBannerPlugin({
      banner: ` Version: ${appVersion}\n branch: ${appGitBranch}\n commit: ${appGitCommit}`,
      file: assetModuleFilename
    }),
    new RemovePlugin({
      after: {
        root: './build',
        include: [
          outputFilename,
        ],
      }
    })
  ],
  output: {
    path: path.resolve(__dirname, 'build'),
    clean: false,
    filename: outputFilename,
    assetModuleFilename,
  },
};
