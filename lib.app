module elib/elib-clientsidediff/lib


//Mark new or deleted files by setting name to /dev/null for the missing file
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
    let leftSplit = leftVal !== '' ? leftVal.split('\n') : undefined;
    let rightVal = $('#~rightElemId').val();
    let rightSplit = rightVal !== '' ? rightVal.split('\n') : undefined;
    let diff = difflib.unifiedDiff(
      leftSplit,
      rightSplit,
      {
        fromfile: '~leftName',
        tofile: '~rightName',
        lineterm: ''
      }
    );

    //inject deleted/new file instructions when applicable, to display correct mode with Diff2HtmlUI
    if(diff.length >= 2){
      if( diff[1].endsWith("/dev/null") && !diff[2].includes('deleted file') ){
        diff.splice(2, 0, "deleted file mode 000000");
      } else if( diff[0].endsWith("/dev/null") && !diff[2].includes('new file') ){
        diff.splice(2, 0, "new file mode 000000");
      }
    };
    let diffStr = diff.join('\n');
    
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

    let diff2htmlUi = new Diff2HtmlUI(diffContainer, diffStr, diffDisplayConfig);
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