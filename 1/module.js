/*
 *  courselab-customization version: "v0.0.2"
 *  commit: "6560aa57"
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

// Used to properly scale to fit the window(adds extra space for the shadow).
const boxShadowMargin = 25;

const minWidth = BREAKPOINT_VALUES[BREAKPOINT.MOBILE];

let $boardFrame;
let $window;
let currentBreakpoint;

/**
 * Prepare the courseLab markup to work using breakpoints approach.
 */
function makeMarkupResponsive(){

  //TODO: check function Mobile 8077 cl.js (work in the webtutor)

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
    height: courseHeight+'px', // add vertical scroll in case the user opens the course on a small window(small phone or landscape orientation)
    transformOrigin: 'top',
  }).parent().css({ // cl-container
    width: '100%', // remove fixed width value;
    height: '100%', // remove fixed height value;
    margin: 0, // remove current margin(was used for the centering cl-container)
    position: 'static', // set the default position
    transform: 'none', // remove transform(was used for the scaling cl-container)
    display: "flex", // new way of the centered layout
    justifyContent: "center",
    overflow: "visible",
    minWidth: minWidth+'px', // set horizontal scroll in the case user opens the course on a small phone
    boxShadow: 'none' // remove .cl-container box-shadow style(move it into the boardFrame)
  });
}

function updateBreakpoint(resizeEvent, bSync = true){

  const width = $window.width();

  if(CLZ.sCurrentSlideId === ""){
    return;
  }

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

    if(bSync){
      synchronizeComponents();
    }

    // Switch view according to the new breakpoint
    $boardFrame.width(BREAKPOINT_VALUES[currentBreakpoint]);
    CLM[currentBreakpoint].Show();
    CL.Navigation.GoTo({ sTargetType: "frame", sTargetId: frameIdMap[currentBreakpoint] });
  }

  if(CLZ.bFitWindow){
    // TODO: add throttling
    scaleToFitWindow();
  }
}

/**
 * Functionality for synchronizing components between breakpoints.
 * Try to synchronize the same components on the current slide when switching frames.
 */
function synchronizeComponents(){

  let componentsToSync = {
    onTheFrame: [],
    notOnTheFrame: [],
    get length() {
      return this.onTheFrame.length + this.notOnTheFrame.length;
    },
  };

  // CLZ.oStore contains all CourseLab objects(CLO) keys with their custom data if any
  Object.keys(CLZ.oStore).forEach((objKey)=>{

    // Try to sync simple objects that use the same variable(sVarName) on the current slide
    // (for example objects with sType  "form_006_select", "form_004_checkbox" and etc.)
    // CLO contains all CourseLab objects on the current slide
    const clObj = CLO[objKey];
    // So find variable name for this courseLab object if any
    if(clObj && clObj.data){

      // If some cl-objects have a bSync property, we try to synchronize their data
      if(clObj.data.bSync){
        if(clObj.sFrameId === CLZ.sCurrentFrameId){
          componentsToSync.onTheFrame.push(clObj);
        }else{
          componentsToSync.notOnTheFrame.push(clObj);
        }
      }

      const sVarName = clObj.data.sVarName;
      if(sVarName){

        // CLV.oSlide contains all CourseLab variables existing on the current slide
        // Find current variable value and set this value for all courseLab objects data that uses this variable.
        const sVarCurrentValue = CLV.oSlide[sVarName];

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
    }
  });

  if(componentsToSync.length){
    // For the current visible objects(on the current frame)
    // find corresponding objects on other frames and sync their data.
    componentsToSync.onTheFrame.forEach((objOnTheFrame)=>{
      componentsToSync.notOnTheFrame.forEach((objToSync)=>{
        const { syncId, iCurrent } = objOnTheFrame.data;
        const sType = objOnTheFrame.sType;

        if(syncId === objToSync.data.syncId && sType === objToSync.sType){
          // Update data in the CL store for the objToSync from the objOnTheFrame with the same syncId
          CLZ.oStore[objToSync.sId] = [...CLZ.oStore[objOnTheFrame.sId]];

          switch (sType) {
            case 't1_accordion':
            case 't1_tabs':
              // Update selected element for the objToSync
              objToSync.CallMethod({ sMethod: "Display", oMethodArgs: { elindex: iCurrent } });
              break;
            default:
              // ... add custom logic to update view for the other cl-objects types
              break;
          }
        }
      })
    })
  }
}

function scaleToFitWindow(){
  let scale = 1;
  let scaleX = 1;
  let scaleY = 1;

  var frameWidth = $boardFrame.width();
  var frameHeight = $boardFrame.height();
  var windowWidth = $window.width() - boxShadowMargin;
  var windowHeight = $window.height() - boxShadowMargin;

  scaleX = windowWidth/frameWidth;
  scaleY = windowHeight/frameHeight;
  scale = Math.round(1000*Math.min(scaleX,scaleY))/1000;

  if(scale<1){
    scale = 1
  }

  $boardFrame.css({
    transform: 'scale(' + scale + ')'
  });
}

/**
 * Turn off the courseLab Zoom functionality
 */
function disableCLZoom(){
  CL.Zoom = function(arg){
    // Also disable the fitscreen function from the nav_0001_toggle_btn component(arg.bNaviBtn: true)
    // Use the scaleToFitWindow method instead.
    return false;
  }
}

function InitModule()
{
  $boardFrame = $(CL.oBoard);
  $window = $(window);

  disableCLZoom();

  makeMarkupResponsive();

  $(window).resize(updateBreakpoint);

  // Store the original CLSlide Destroy method
  CLSlide.prototype.CLDestroy = CLSlide.prototype.Destroy;

  CLSlide.prototype.Destroy = function (oArgs){

    // synchronize components before destroying.
    // Use case: user changes a breakpoint on another slide and then returns to this slide.
    synchronizeComponents();

    // Call the original CLSlide Destroy method (something like 'super')
    CLSlide.prototype.CLDestroy.call(this, oArgs);
  }

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
    updateBreakpoint(null, false);
  }
}

function ShutdownModule()
{
  $(window).off("resize", updateBreakpoint);
}
