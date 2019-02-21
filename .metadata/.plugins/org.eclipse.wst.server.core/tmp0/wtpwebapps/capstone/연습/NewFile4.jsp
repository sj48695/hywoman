<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <script type="text/javascript">
      function linkDownload(a, filename, content) {
        contentType =  'data:application/octet-stream,';
        uriContent = contentType + encodeURIComponent(content);
        a.setAttribute('href', uriContent);
        a.setAttribute('download', filename);
      }
      function download(filename, content) {
        var a = document.createElement('a');
        contentType =  'data:application/octet-stream,';
        uriContent = contentType + encodeURIComponent(content);
        a.setAttribute('href', uriContent);
        a.setAttribute('download', filename);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
      }
    </script>
   </head>
  <body>
    <a href="#" onclick="linkDownload(this, '1.jpg', '');">download</a>
    <button onclick="download('test.txt', 'Hello World!');">download</button>

</body>
</html>