s/\t/<\/td><td>/g
s/^/<tr><td>/g
s/$/<\/td><\/tr>/g

1i <html>\n<head><style> table, th, td { border: 1px solid black; } table tr td:last-child { background-color: #FF0000; } table { border-collapse: collapse; } td,th { padding: 5px; } <\/style><\/head><body><table><tr><th>Name<\/th><th>Position<\/th><th>Office<\/th><th>Age<\/th><th>Start date<\/th><th>Salary<\/th><\/tr>

$a <\/table><\/body><\/html>

