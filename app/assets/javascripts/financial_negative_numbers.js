$(document).ready(function(){
    if($('.table').length) { // previne o codigo de dar erro em outra pagina que nao tenha uma table
        var table, tbody, rowCount, cellCount, value;
        table=document.getElementsByTagName('table')[0];
        if(table.childNodes[1]) tbody=table.childNodes[3];
        if(tbody) rowCount=tbody.childNodes.length;
        for(i=1;i<rowCount;i++){
            cellCount=tbody.childNodes[i].childNodes.length;

            for(j=1;j<cellCount;j++){
                value=tbody.childNodes[i].childNodes[j].outerText;
                if(value.substr(0, 3) == '-R$') { 
                    tbody.childNodes[i].childNodes[j].setAttribute('style','background-color: #eabbbb'); 
                }
                j+=1;
            }
            i+=1;
        }
    }
});