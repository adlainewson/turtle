# Server Manual Readme

To make edits to the server manual, edit the markdown file server.md, run it through the markdown-to-html converter available at http://daringfireball.net/projects/markdown/dingus, then add the HTML in server_header.html at the top of the output, and save as server-manual.html. 

This next part is a bit janky; there are problems with the HTML convert, so if you want to pretty it up there are some things you have to fix. For example, <img> tags need to get wrapped by <center> tags and code blocks benefit from a <pre> wrapping. Maybe you have a more efficient way to fix this stuff up, but I couldn't figure it out with the CSS in the header. 

Here are some vim replacements that will speed it up:
```
:%s/<p><code>/<p><code><pre>/g
:%s/<\/code><\/p>/<\/pre><\/code><\/p>/g
```

Some other problems: 
   * Fix the numbering for the "How to Connect" part of the table of contents

Finally, copy server-manual.html to the apache www directory on the server. Right now the file is called server-manual.html, and it's at /var/www/html (you need root access)

