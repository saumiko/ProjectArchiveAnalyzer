/**
 * 
 */
<script>
alert("aaisi");
function validation(){

	var text=document.getElementById('deadline').toString();
  var num=0;
for(var i=0;i<text.length;i++)
	{
	if(i==4||i==7||i==10 ||i==13||i==16)
		{
		 if(text.charAt(i)!='-' || text.charAt(i)!='-' text.charAt(i)!=' '|| text.charAt(i)!=':'||text.charAt(i)!=':')
			    alert("Formate Missmatched");
		  
		}
	else if( text.charAt(i)>='0' &&text.charAt(i)<='9')
	{
		num++;
	}
	else 
		{
		alert("Formate Missmatched");
		}
	
	}
	if(num==14)
		 return true;
	return false;
}
</script>