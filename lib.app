module elib/elib-clientsidediff/lib


template showDiff( leftName : String, leftVersion : String, rightName : String, rightVersion : String){
  var leftElemId := id+"_left"
  var rightElemId := id+"_right"
  var diffContainerId := id+"_diff"

  diffIncludes
  
  <input id=leftElemId type="hidden" value=leftVersion/>
  <input id=rightElemId type="hidden" value=rightVersion />
  div[id=diffContainerId]{}
  
  <script>
  $( function(){
    let leftVal = $('#~leftElemId').val();
    let rightVal = $('#~rightElemId').val();
    let diff = difflib.unifiedDiff(
      leftVal.split('\n'),
      rightVal.split('\n'),
      {
        fromfile: '~leftName',
        tofile: '~rightName',
        lineterm: ''
      }
    ).join("\n");
    let diffContainer = document.getElementById("~diffContainerId");
    const diffDisplayConfig = {
        drawFileList: false,
        fileListToggle: false,
        fileListStartVisible: false,
        fileContentToggle: false,
        matching: 'lines',
        outputFormat: 'line-by-line',
        synchronisedScroll: true,
        highlight: true,
        renderNothingWhenEmpty: false
    };

    let diff2htmlUi = new Diff2HtmlUI(diffContainer, diff, diffDisplayConfig);
    diff2htmlUi.draw();
    } );
  </script>
}

template diffIncludes(){
  includeJS("difflib-browser.js")

  // includeJS("diff2html-ui.min.js")      //includes the wrapper of diff2html with highlight for all highlight.js supported languages
  includeJS("diff2html-ui-slim.min.js")    //includes the wrapper of diff2html with "the most common" highlight.js supported languages
  // includeJS("diff2html-ui-base.min.js") //includes the wrapper of diff2html without including a highlight.js implementation. You can use it without syntax highlight or by passing your own implementation with the languages you prefer
  
  includeCSS("highlight-js-github.css")
  includeCSS("diff2html.min.css")
}