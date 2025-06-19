const api = '/todos';
async function load(){
  const list = document.getElementById('list'); list.innerHTML='';
  (await fetch(api).then(r=>r.json())).forEach(t=>{
    const li=document.createElement('li'); li.textContent=t.title;
    const btn=document.createElement('button'); btn.textContent='×';
    btn.onclick=()=>fetch(`${api}/${t._id}`,{method:'DELETE'}).then(load);
    li.append(btn); list.append(li);
  });
}
document.getElementById('form').onsubmit=e=>{
  e.preventDefault();const v=document.getElementById('input').value;
  fetch(api,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({title:v})})
    .then(()=>{document.getElementById('input').value='';load();});
};
load();