#!/bin/bash 

fsitemap=sitemap.xml
flist=`mktemp`;
urlbase="http://huichen-cs.github.io"

find content course -type f  \
    -iregex "^.*\.html\|^.*\.m\|^.*\.pdf\|^.*\.c\|^.*\.cpp\|^.*\.java" | \
    grep -v template >> ${flist}

[ -r ${fsitemap} ] && rm -f ${fsitemap}
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > ${fsitemap}
echo "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">" >> ${fsitemap}

while read fn
do
    url=${urlbase}/${fn}
    timestamp=`date -r "${fn}" -u +%Y-%m-%dT%H:%M:%S%:z`
    echo "<url><loc>${url}</loc><lastmod>${timestamp}</lastmod></url>" >> ${fsitemap}
done < ${flist}

echo "</urlset>" >> ${fsitemap}
rm -f ${flist}





