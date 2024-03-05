const BREAKPOINT = {
  MOBILE: 'MOBILE',
  TABLET: 'TABLET',
  DESKTOP: 'DESKTOP',
};

const BREAKPOINT_VALUES = {
  [BREAKPOINT.MOBILE]: 360,
  [BREAKPOINT.TABLET]: 768,
  [BREAKPOINT.DESKTOP]: 1280,
};

const minWidth = BREAKPOINT_VALUES[BREAKPOINT.MOBILE];

let $boardFrame;
let currentBreakpoint;

/**
 * Prepare the courseLab markup to work using breakpoints approach.
 */
function makeMarkupResponsive(){

  // Set viewport for correct work on the mobile devices
  const jMeta = $("head").children("meta[name='viewport']");
  jMeta.attr({ "content": "width=device-width, initial-scale=1" });

  if(!$boardFrame){
    return;
  }

  // store original course height
  const courseHeight = $boardFrame.parent().height();

  $boardFrame.css({
    position: 'relative', // remove absolute positioning;
    boxShadow: '0 10px 25px rgba(0, 0, 0, 0.5)',// apply.cl-container box-shadow style
  }).parent().css({ // cl-container
    width: '100%', // remove fixed width value;
    height: '100%', // remove fixed height value;
    margin: 0, // remove current margin(was used for the centering cl-container)
    position: 'static', // set the default position
    transform: 'none', // remove transform(was used for the scaling cl-container)
    display: "flex", // new way of the centered layout
    justifyContent: "center",
    minHeight: courseHeight+'px', // add vertical scroll in case the user opens the course on a small window(small phone or landscape orientation)
    minWidth: minWidth+'px', // set horizontal scroll in the case user opens the course on a small phone
    boxShadow: 'none' // remove .cl-container box-shadow style(move it into the boardFrame)
  });
}



function updateBreakpoint(){

  const width = $(window).width();

  const frameIds = CLS[CLZ.sCurrentSlideId].aFrameIds;

  const frameIdMap = {
    [BREAKPOINT.MOBILE]: frameIds[2],
    [BREAKPOINT.TABLET]: frameIds[1],
    [BREAKPOINT.DESKTOP]: frameIds[0],
  }

  const breakpoint = Object.keys(BREAKPOINT_VALUES).reduce((acc,current)=>{
    if(width >= BREAKPOINT_VALUES[current] && BREAKPOINT_VALUES[current] > BREAKPOINT_VALUES[acc]){
      return current;
    }
    return acc;
  }, BREAKPOINT.MOBILE);


  if(currentBreakpoint!==breakpoint){
    currentBreakpoint = breakpoint;

    // Switch view according to the new breakpoint
    $boardFrame.width(BREAKPOINT_VALUES[currentBreakpoint]);
    CLM[currentBreakpoint].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: frameIdMap[currentBreakpoint] });
  }
}

function InitModule()
{
  $boardFrame = $(CL.oBoard);

  makeMarkupResponsive();

  $(window).resize(updateBreakpoint);

  // TODO: use method extend - Constructor pattern by Douglas Crockford
  CLSlide.prototype = Object.create(CLSlide.prototype);
  // Update Breakpoint for the new Slide
  CLSlide.prototype.Start = function (oArgs){
    // console.log('Start', oArgs);
    CLSlide.prototype.__proto__.Start.call(this, oArgs);
    CLM[this.sMasterId].Hide();
    // reset breakpoint
    currentBreakpoint = undefined;
    updateBreakpoint();
  }
}

function ShutdownModule()
{
  $(window).off("resize", updateBreakpoint);
}
