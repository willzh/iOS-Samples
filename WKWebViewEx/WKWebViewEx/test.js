 <!DOCTYPE HTML>
<html lang="zh-CN">
<body>
<p>这是一个测试网页</p>
<p>这是一个测试网页</p>
<p>这是一个测试网页</p>
<p>这是一个测试网页</p>
<h1>这是一个测试网页</h1>
    <p>这是一个测试网页</p>

    <body>
<button onclick="alertFunc()">Touch to call iOS method</button>
<button onclick="alertFunc2()">Touch to call iOS method 2</button>
  </body>
  <script>
  function alertFunc() {
      window.webkit.messageHandlers.methodIniOS.postMessage({'param1': 'aaa', 'param2':'bbb'});
  }
function alertFunc2() {
    window.webkit.messageHandlers.methodIniOS.postMessage('post message body');
}
  </script>
 </html>
