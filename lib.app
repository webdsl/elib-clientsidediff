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
  // includeJS("diff2html-ui.min.js")
  includeJS("diff2html-ui-slim.min.js")
  includeCSS("highlight-js-github.css")
  includeCSS("diff2html.min.css")
}