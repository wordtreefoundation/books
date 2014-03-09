cat <<-HTML
<html>
<head>
  <style>
  span.delstrike { text-decoration: line-through; color: red; }
  span.delete { color: red; font-weight: bold; }
  span.insert { color: blue; font-weight: bold; }
  body { margin: 1em 10em; font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", 
    Helvetica, Arial, "Lucida Grande", sans-serif; }
  a { color: black; }
  table.comparison { border-collapse: collapse; }
  table.comparison td b, .red { color: #DE3E39; }
  table.comparison td i, .orange { font-weight: bold; color: #DE8E39; }
  table.comparison td { border-bottom: 1px solid #999; padding: 0.2em 0.5em 0.5em 0.5em; vertical-align: top; }
  table.comparison td b.c1, b.c1 { color: #3E39DE; }
  table.comparison td b.c2, b.c2 { color: #3EBE39; }
  table.comparison td b.c3, b.c3 { color: #DE3E39; }
  table.comparison td b.c4, b.c4 { color: #DE8E39; }
  table.comparison td b.c5, b.c5 { color: #BABA39; text-decoration: underline;}
  table.comparison td b.c6, b.c6 { color: #399999; }
  table.comparison td b.c7, b.c7 { color: #A059D9; }
  table.comparison td b.c8, b.c8 { color: #222222; }
  table.comparison td b.black, b.black { color: #333; }
  </style>
</head>
<body>
  <table class="comparison">
    <tr>
      <th width="33.3%">The Late War&mdash;1816</th>
      <th width="33.3%">Difference</th>
      <th width="33.3%">Historical Reader&mdash;1819</th>
    </tr>
HTML

for i in `seq 0 56`; do

if [[ $i == "0" ]]; then
  chap_first='\[BEGIN\]'
else
  chap_first="CHAP\\. $(ruby roman.rb $i)\\."
fi

chap_last="$(($i+1))"
if [[ $chap_last == "56" ]]; then
  chap_last='\[END\]'
else
  chap_last="CHAP\\. $(ruby roman.rb $chap_last)\\."
fi

  # echo "chap_first: $chap_first"
  # echo "chap_last: $chap_last"

cat <<-HTML
    <tr>
      <td>
HTML

dwdiff \
  -2 \
  -i --aggregate-changes \
  -A best \
  -w '<span class="delete">' -x '</span>' \
  -y '<span class="insert">' -z '</span>' \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1816.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")') \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1819.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")')

# cat <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1816.md' | 
#     sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
#     sed -E 's/^[0-9]+ *//' |
#     sed -E 's/\[[^]]+\]//' |
#     ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")') \

cat <<-HTML
      </td>
      <td>
HTML

dwdiff \
  -i --aggregate-changes \
  -A best \
  -w '<span class="delstrike">' -x '</span>' \
  -y '<span class="insert">' -z '</span>' \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1816.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/^[0-9]+ *//' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")') \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1819.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/^[0-9]+ *//' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")')

cat <<-HTML
      </td>
      <td>
HTML

dwdiff \
  -1 \
  -i --aggregate-changes \
  -A best \
  -w '<span class="delete">' -x '</span>' \
  -y '<span class="insert">' -z '</span>' \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1816.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")') \
  <(cat 'pseudo_biblical/The Late War - Gilbert Hunt - 1819.md' | 
    sed -n "/$chap_first/,/$chap_last/p" | sed '$d' |
    sed -E 's/\[[^]]+\]//' |
    ruby -e 'puts $stdin.read.gsub(/\n\s*\n\s*\n/m, "\n\n").gsub("\n", "\n<br>")')

cat <<-HTML
      </td>
    </tr>
HTML

done

cat <<-HTML
  </table>

</body>
HTML