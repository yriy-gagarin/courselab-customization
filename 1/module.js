/*
 *  courselab-customization version: "v0.0.1"
 *  commit: "8791aa41"
 */
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

    synchronizeComponents();

    // Switch view according to the new breakpoint
    $boardFrame.width(BREAKPOINT_VALUES[currentBreakpoint]);
    CLM[currentBreakpoint].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: frameIdMap[currentBreakpoint] });
  }
}

/**
 * Experimental functionality for synchronizing components between breakpoints.
 * Try to synchronize the same components on the current slide when switching frames.
 */
function synchronizeComponents(){

  var iCurrent;
  var oStore;

  // CLZ.oStore contains all CourseLab objects(CLO) keys with their custom data if any
  Object.keys(CLZ.oStore).forEach((objKey)=>{

    // Try to sync simple objects that use the same variable(sVarName) on the current slide
    // (for example objects with sType  "form_006_select", "form_004_checkbox" and etc.)
    // CLO contains all CourseLab objects on the current slide
    const clObj = CLO[objKey];
    // So find variable name for this courseLab object if any
    if(clObj){
      const sVarName = clObj.data && clObj.data.sVarName;
      if(sVarName){

        // CLV.oSlide contains all CourseLab variables existing on the current slide
        // Find current variable value and set this value for all courseLab objects data that uses this variable.
        const sVarCurrentValue = CLV.oSlide[sVarName]

        // Update all courseLab objects custom data that uses this variable
        CLZ.oStore[objKey][0] = sVarCurrentValue;//CLV.oSlide[CLO[objKey].data.sVarName];

        // Special case for "form_006_select":
        // Update the sCurrentValue field now since it only updates when switching slides and
        // not updating when switching frames (see the "form_006_select" constructor logic)
        if(clObj.data.sCurrentValue){
           //clObj.data.sCurrentValue = CLV.oSlide[CLO[objKey].data.sVarName];
        }

        // Rerender current courseLab object to update in view with the new value
        clObj.Render();
      }

      // TODO: try to sync the v_rapid_001 component
      /*if(CLO[elem].data.iCurrent!==undefined){
        if(iCurrent===undefined){
          iCurrent = CLO[elem].data.iCurrent;
          oStore = CLZ.oStore[elem];
        }
        console.log('iCurrent = '+ CLO[elem].data.iCurrent);
        CLO[elem].data.iCurrent = iCurrent
        CLZ.oStore[elem] = oStore;
      }*/
    }
  });
}

function InitModule()
{
  $boardFrame = $(CL.oBoard);

  makeMarkupResponsive();

  $(window).resize(updateBreakpoint);

  // Store the original CLSlide Start method
  CLSlide.prototype.CLStart = CLSlide.prototype.Start;

  // Override the original CLSlide Start method
  CLSlide.prototype.Start = function (oArgs){

    // Call the original CLSlide Start method (something like 'super')
    CLSlide.prototype.CLStart.call(this, oArgs);

    CLM[this.sMasterId].Hide();
    // reset breakpoint
    currentBreakpoint = undefined;
    // update Breakpoint for the new Slide
    updateBreakpoint();
  }
}

function ShutdownModule()
{
  $(window).off("resize", updateBreakpoint);
}
