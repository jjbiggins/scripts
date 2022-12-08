
PYTHONRESOURCES=/Library/Frameworks/Python.framework/Resources
PYTHONDOCUMENTATION="${PYTHONRESOURCES}/English.lproj/Documentation"
SEARCH_ENDPOINT="file://${PYTHONDOCUMENTATION}/search.html"


KEYWORD="q=${1}"
QUERY="${KEYWORD}&check_keywords=yes&area=default"

#SEARCH_OPTIONS="${SEARCH_ENPOINT}q=${QUERY}"
CHECK_KEYWORDS='check_keyword=yes'
AREA='area=default'

curl \
	--data-urlencode "${QUERY}" \
	--data-urlencode "${CHECK_KEYWORDS}" \
	--data-urlencode "${AREA}" \
	"${SEARCH_ENDPOINT}"


