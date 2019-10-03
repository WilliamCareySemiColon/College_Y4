/* Copyright 2017,2019 Oracle and/or its affiliates. All rights reserved.
 * Version: 2019.09.04
 * Legal Notices: http://docs.oracle.com/cd/E23003_01/html/en/cpyr.htm
 */

window.ohcglobal = "1.0.1";

(function () {

//for IE without debug console open
if (!window.console) {
  window.console = {
    log: function () {}
  };
}

//Test for http[s] so we can know if we are using other protocols like file://
function isHttp() {
  //return true;
  if(window.location.href.split('/')[0].indexOf("http") === 0) {
    return true;
  } else {
    return false;
  }
}

//Is current window not in a frame?
function isNotFramed() {
  try {
    //If the current window (self) is the same as the top window, then it is the main window
    return window.self === window.top;
  } catch (e) {
    return true;
  }
}

function addFooterBanner() {
  //Disclaimer banner for cookie preference
  var msg = '<ul><li><div id="teconsent" style="display: inline-block;"></div></li><li><a id="adchoices" class="new-window" target="_blank" href="https://www.oracle.com/legal/privacy/marketing-cloud-data-cloud-privacy-policy.html#12">Ad Choices</a></li></ul>';
  var rules = "";
  rules += "#footer-banner {";
  rules += "z-index: 9999;";
  rules += "position: relative;";
  rules += "background-color: white;";
  rules += "margin: 0 auto 0 auto;";
  rules += "color: #333;";
  rules += "padding: 0.0em 1em;";
  rules += "text-align: center;";
  rules += "font-size: 12px !important;";
  rules += "line-height: 28px;";
  rules += "font-weight: normal;";
  rules += "font-family: 'Helvetica Neue', Helvetica, 'Open Sans', arial, sans-serif;";
  rules += "clear: both;";
  rules += "}";
  rules += "#footer-banner ul {";
  rules += "list-style: none;";
  rules += "font-size: 12px !important;";
  rules += "padding: 0;";
  rules += "margin: 0;";
  rules += "margin-right: 20px;";
  rules += "}";
  rules += "#footer-banner li {";
  rules += "display: inline-block;";
  rules += "}";
  rules += "#footer-banner li + li:before {";
  rules += "content: \"|\";";
  rules += "margin-right: 4px;";
  rules += "margin-left: 2px;";
  rules += "color: #333;";
  rules += "}";
  rules += "#footer-banner a, #footer-banner a:focus, #footer-banner a:hover {";
  rules += "color: #333;";
  rules += "text-decoration: underline;";
  rules += "}";
  var myElem = document.getElementById('banner_footer_style');
  if (myElem === null) {
    addCss(rules, "banner_footer_style");
  }

  myElem = document.getElementById('footer-banner');
  if (myElem === null) {
    modifyDocFooter( msg );
  }
}

//Add CSS to target main content window only
function addCss(rules, id) {
  var style = document.createElement('style');
  style.setAttribute("id", id);
  style.type = 'text/css';
  if (style.styleSheet) {
    style.styleSheet.cssText = rules;
  } else {
    style.appendChild(document.createTextNode(rules));
  }
  document.getElementsByTagName("head")[0].appendChild(style);
}

//This is where we actually attach our footer to the page
function modifyDocFooter(msg) {
  var footerDiv = document.createElement('div');
  footerDiv.setAttribute("id", "footer-banner");
  footerDiv.innerHTML = msg;
  document.body.appendChild(footerDiv);
  applyConsent();
}

//Places the cookie preference in place
function applyConsent() {
  var consentScript = document.createElement('script');
  consentScript.type = "text/javascript";
  consentScript.src = "https://consent.truste.com/notice?domain=oracle.com&c=teconsent&js=bb&cdn=1&pcookie&noticeType=bb&text=true";
  document.body.appendChild(consentScript);
}

//This is where we attach our site catalyst to the page
function addSiteCatalyst() {
  console.log("global.js site catalyst load");
  var oraScript = document.createElement('script');
  oraScript.type = "text/javascript";
  oraScript.src = "https://www.oracleimg.com/us/assets/metrics/ora_docs.js";
  document.getElementsByTagName('head')[0].appendChild(oraScript);
}

//runs after dom and after a 2 second delay to allow other scripts to finish
function delayedFunction() {
  //Only run on main frame
  if(isHttp() && isNotFramed()) {
    //TODO: Should we be searching all frames (documents) for teconsent in case it does exist in a frame?
    //Otherwise, we could be duplicating
    //If teconsent does not exist, then we have to use our customer footer banner to display cookie preferences
    var consent = document.getElementById('teconsent');
    if (consent === null) {
      addFooterBanner();
    }

    //Detect if sitecatalyst is needed
    if (window.oraVersion == null) {
      addSiteCatalyst();
    }
  }
}

//Runs after dom
function onLoad() {
  var consent = document.getElementById('teconsent');
  if (consent === null) {
    //console.log("global.js onLoad");
    var cookieMsg = '<a id="teconsent" href="#"></a>';
    var disclaimerSet = false;
    var javaApiDisclaimer = document.querySelector("a[href='http://www.oracle.com/technetwork/java/redist-137594.html']") ||
                            document.querySelector("a[href='https://www.oracle.com/technetwork/java/redist-137594.html']");
    if(javaApiDisclaimer) {
      //console.log("jd");
      var preCookieMsg = 'Modify ';
      var AdChoiceMsg = '. Modify <a id="adchoices" target="_blank" href="https://www.oracle.com/legal/privacy/marketing-cloud-data-cloud-privacy-policy.html#12">Ad Choices</a>.';
      var disclaimerElement = document.createElement('span');
      disclaimerElement.innerHTML = preCookieMsg + cookieMsg + AdChoiceMsg;
      javaApiDisclaimer.parentElement.appendChild(disclaimerElement);
      disclaimerSet = true;
      applyConsent();
    }

    // targets many aplg era pubs with the US "Your Privacy Rights" link
    var aplgDisclaimer = document.querySelector("ul > li > a[href='http://www.oracle.com/us/legal/privacy/index.html']") || 
                         document.querySelector("ul > li > a[href='https://www.oracle.com/us/legal/privacy/index.html']");
    if(aplgDisclaimer) {
      //console.log("aplg");
      var AdChoiceMsg = '<a id="adchoices" target="_blank" href="https://www.oracle.com/legal/privacy/marketing-cloud-data-cloud-privacy-policy.html#12">Ad Choices</a>';
      var disclaimerLi = aplgDisclaimer.parentElement;
      var disclaimerUl = aplgDisclaimer.parentElement.parentElement;
      var li1 = document.createElement("li");
      if (disclaimerLi.className !== "") li1.className = disclaimerLi.className;
      li1.id = "teconsent";
      var li2 = document.createElement("li");
      if (disclaimerLi.className !== "") li2.className = disclaimerLi.className;
      li2.innerHTML = AdChoiceMsg;
      disclaimerUl.appendChild(li1);
      disclaimerUl.appendChild(li2);
      disclaimerSet = true;
      applyConsent();
    }

    var peopleSoftDisclaimer = document.querySelector("a.footerlink[href='http://www.oracle.com/us/legal/privacy/overview/index.html']") ||
                               document.querySelector("a.footerlink[href='https://www.oracle.com/us/legal/privacy/overview/index.html']");
    if(peopleSoftDisclaimer) {
      //console.log("ps");
      var AdChoiceMsg = '<a id="adchoices" target="_blank" href="https://www.oracle.com/legal/privacy/marketing-cloud-data-cloud-privacy-policy.html#12">Ad Choices</a>';
      var disclaimerDiv = peopleSoftDisclaimer.parentElement;
      var spanSeparator1 = document.createElement("span");
      var spanSeparator2 = document.createElement("span");
      spanSeparator1.className = "separator";
      spanSeparator1.id = "teconsent";
      spanSeparator2.className = "separator";
      var link = document.createElement("a");
      link.id = "adchoices";
      link.className = "footerlink";
      link.target = "_blank";
      link.href = "https://www.oracle.com/legal/privacy/marketing-cloud-data-cloud-privacy-policy.html#12";
      link.innerHTML = AdChoiceMsg;
      disclaimerDiv.appendChild(spanSeparator1);
      disclaimerDiv.appendChild(spanSeparator2);
      spanSeparator2.appendChild(link);
      disclaimerSet = true;
      applyConsent();
    }

    if(disclaimerSet) {
      top.window.disclaimerSet=true;
      //Detect if sitecatalyst is needed
      if (window.oraVersion == null) {
        addSiteCatalyst();
      }
    } else if( window.location !== window.parent.location) {
      // framed, do nothing
    } else {
      // not framed
      setTimeout(function(){
        if(!window.disclaimerSet) {
          // add the big ugly
          //delayedFunction;
        }
      }, 2000);
    }
  }
}

//Code below runs the onLoad method above after the dom is loaded
if (document.readyState == 'complete') {
  onLoad();
} else if (window.addEventListener) {
  window.addEventListener('load', onLoad, false);
}  else if (window.attachEvent) {
  window.attachEvent('onload', onLoad);
} else {
  window.onload = onLoad;
}

})();