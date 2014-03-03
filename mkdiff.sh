cat <<-HTML
<html>
<head>
  <style>
  span.delete { text-decoration: line-through; color: red; }
  span.insert { color: blue; font-weight: bold; }
  body { margin: 1em 10em; }
  </style>
</head>
<body>
HTML

# 
dwdiff \
  -i --aggregate-changes \
  -A best \
  -w '<span class="delete">' -x '</span>' \
  -y '<span class="insert">' -z '</span>' \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1816.md' | 
    sed -n '/\[BEGIN\]/,/\[END\]/p' |
    sed -E 's/^[0-9]+ *//' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")') \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1819.md' | 
    sed -n '/\[BEGIN\]/,/\[END\]/p' |
    sed -E 's/^[0-9]+ *//' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")')

cat <<-HTML
</body>
HTML