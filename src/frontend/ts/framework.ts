class FrameWork{
                     
    public ejecutarBackEnd(metodo: string, url: string,lister:HttpResponse,data?:any) {
      let xmlHttp: XMLHttpRequest = new XMLHttpRequest();
          xmlHttp.onreadystatechange = () => {
            if (xmlHttp.readyState == 4) {
              if (metodo == "GET") {
                lister.handlerResponse(xmlHttp.status,xmlHttp.responseText)
              } else if (metodo == "POST" && url.includes(`/usuarios/`) ) {
                lister.handlerResponseUpdateDevice(xmlHttp.status,xmlHttp.responseText)
              } else if (metodo == "POST" && url.includes(`/updateDevice/`) ) {
                lister.handlerResponseUpdateDevice(xmlHttp.status,xmlHttp.responseText)
              } else if (metodo == "POST" && url.includes("deleteDevice") ) {
                lister.handlerResponseRemoveDevice(xmlHttp.status,xmlHttp.responseText)
              }  else if (metodo == "POST" && url.includes("insertRow") ) {
                lister.handlerResponseAddDevice(xmlHttp.status,xmlHttp.responseText)
              }
              }
      }
  
          xmlHttp.open(metodo, url, true);
          if (metodo == "POST") {
            xmlHttp.setRequestHeader("Content-Type", "application/json")
            xmlHttp.send(JSON.stringify(data))
          } else {
            xmlHttp.send();  
          }
      
            
    }
    public recoverElement(id: string): HTMLElement{
      let element = document.getElementById(id);
      return element;
  
    }
  }