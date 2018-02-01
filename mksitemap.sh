#!/bin/bash 

flist=`mktemp`;

find content course -type f  \
    -iregex "^.*\.html\|^.*\.m\|^.*\.pdf\|^.*\.c\|^.*\.cpp\|^.*\.java" | \
    grep -v template >> ${flist}

echo index.html >> ${flist}

make_site_map() {
    httpproto=$1
    fsitemap=$2

    urlbase="${httpproto}://huichen-cs.github.io"

    [ -r ${fsitemap} ] && rm -f ${fsitemap}
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > ${fsitemap}
    echo "<urlset xmlns=\"${httpproto}://www.sitemaps.org/schemas/sitemap/0.9\">" >> ${fsitemap}

    while read fn
    do
        if [[ ${fn} = *"leemis"* ]]; then
            echo ${fn} is being excluded
        else
            url=${urlbase}/${fn}
            timestamp=`date -r "${fn}" -u +%Y-%m-%dT%H:%M:%S%:z`
            echo "<url><loc>${url}</loc><lastmod>${timestamp}</lastmod></url>" >> ${fsitemap}
        fi
    done < ${flist}

    echo "</urlset>" >> ${fsitemap}
}

make_site_map https sitemap.xml
make_site_map http ositemap.xml

rm -f ${flist}





