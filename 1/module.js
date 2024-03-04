const BREAKPOINTS = {
  MOBILE: 'MOBILE',
  TABLET: 'TABLET',
  DESKTOP: 'DESKTOP',
};

const BREAKPOINTS_RANGE = {
  [BREAKPOINTS.MOBILE]: [360, 767],
  [BREAKPOINTS.TABLET]: [768, 1279],
  [BREAKPOINTS.DESKTOP]: [1280, '~'],
};

let $boardFrame;

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
    minWidth: 360+'px', // set horizontal scroll in the case user opens the course on a small phone
    boxShadow: 'none' // remove .cl-container box-shadow style(move it into the boardFrame)
  });
}



function updateBreakpoint(){

  const w = $(window).width();

  const [desktopFrameId,tabletFrameId,mobileFrameId] = CLS[CLZ.sCurrentSlideId].aFrameIds;

  // TODO: optimize - Navigate only if breakpoints have changed
  if(w<768){
    $boardFrame.width(360);
    CLM[BREAKPOINTS.MOBILE].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: mobileFrameId });
  }else if(w>=768 && w<1280){
    $boardFrame.width(768);
    CLM[BREAKPOINTS.TABLET].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: tabletFrameId });
  }else if(w>=1280){
    $boardFrame.width(1280);
    CLM[BREAKPOINTS.DESKTOP].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: desktopFrameId });
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
    updateBreakpoint();
  }
}

function ShutdownModule()
{
  $(window).off("resize", updateBreakpoint);
}
