// JavaScript Document
// Cerrar ventana

function CloseWin(){
alert("hellooood");
//window.opener = top ;
/*ventana=window.parent.self;
 ventana.opener=window.parent.self;
 ventana.close();*/
 //setTimeout("self.close()",4 * 1000);
 window.open('','_parent',''); window.close();

}

// --------------------------------------------

// Inicio de función para llenar las Juris Nayarit
function fillCategory_Juris(){ 
//alert("que pacho");
 // this function is used to fill the category list on load
addOption(document.form.Category, "JURISDICCION SANITARIA Iss","JURISDICCION SANITARIA Iss"); 
addOption(document.form.Category, "JURISDICCION SANITARIA II","JURISDICCION SANITARIA II"); 
addOption(document.form.Category, "JURISDICCION SANITARIA III","JURISDICCION SANITARIA III"); 
//document.form.txtf_ref.focus();
}
// -----------------------------------------------



function show5(){
 if (!document.layers&&!document.all&&!document.getElementById)
 return
 var Digital=new Date()
 var hours=Digital.getHours()
 var minutes=Digital.getMinutes()
 var seconds=Digital.getSeconds()
 var dn="AM" 
 if (hours>12){
 dn="PM"
 hours=hours-12
 }
 if (hours==0)
 hours=12
 if (minutes<=9)
 minutes="0"+minutes
 if (seconds<=9)
 seconds="0"+seconds
//change font size here to your desire
myclock="<font size='3' face='Arial' ><b>"+hours+":"+minutes+":"
 +seconds+" "+dn+"</b></font>"
if (document.layers){
document.layers.liveclock.document.write(myclock)
document.layers.liveclock.document.close()
}
else if (document.all)
liveclock.innerHTML=myclock
else if (document.getElementById)
document.getElementById("liveclock").innerHTML=myclock
setTimeout("show5()",1000)
 }

