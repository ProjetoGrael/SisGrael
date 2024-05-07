function number_pages() {
  let vars = {};
  let x = document.location.search.substring(1).split('&');
  console.log("Financial_report")
  console.log(x)
  for(let i in x) 
    {
      let z = x[i].split('=', 2);
      vars[z[0]] = decodeURIComponent(z[1]);
    }
  x = ['frompage','topage','page','webpage','section','subsection','subsubsection'];
  for(let i in x) 
  {
    var y = document.getElementsByClassName(x[i]);
    for(var j = 0; j < y.length; ++j ) y[j].textContent = vars[x[i]];
  }
}