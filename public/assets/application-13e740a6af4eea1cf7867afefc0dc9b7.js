function facebook(){!function(t,e,n){var o,r=t.getElementsByTagName(e)[0];t.getElementById(n)||(o=t.createElement(e),o.id=n,o.src="//connect.facebook.net/en_US/all.js#xfbml=1",r.parentNode.insertBefore(o,r))}(document,"script","facebook-jssdk")}(function(){var t,e,n,o,r,i,u,c,a,l,d,s,f,h,p,m,v,g,y,w,b,k,E,x,A,T,N,S,H,C,L,R,X,q,M,O,D,B,P,K,$,j,Y,G,I,U={}.hasOwnProperty,_=[].indexOf||function(t){for(var e=0,n=this.length;n>e;e++)if(e in this&&this[e]===t)return e;return-1};u=10,s=null,L=null,k=null,T={},l=null,B=(null!=(I=document.cookie.match(/request_method=(\w+)/))?I[1].toUpperCase():void 0)||"",G=null,v=function(t){var e;return j("page:fetch"),e=O(t),null!=G&&G.abort(),G=new XMLHttpRequest,G.open("GET",e,!0),G.setRequestHeader("Accept","text/html, application/xhtml+xml, application/xml"),G.setRequestHeader("X-XHR-Referer",L),G.onload=function(){var e;return j("page:receive"),(e=H())?(R(t),c.apply(null,p(e)),X(),document.location.hash?document.location.href=document.location.href:K(),j("page:load")):document.location.href=t},G.onloadend=function(){return G=null},G.onabort=function(){return M()},G.onerror=function(){return document.location.href=t},G.send()},m=function(t){var e;return i(),e=T[t],null!=G&&G.abort(),c(e.title,e.body),C(e),j("page:restore")},i=function(){return T[s.position]={url:document.location.href,body:document.body,title:document.title,positionY:window.pageYOffset,positionX:window.pageXOffset},a(u)},S=function(t){return null==t&&(t=u),/^[\d]+$/.test(t)?u=parseInt(t):void 0},a=function(t){var e,n;for(e in T)U.call(T,e)&&(n=T[e],e<=s.position-t&&(T[e]=null))},c=function(e,n,o,r){return document.title=e,document.documentElement.replaceChild(n,document.body),null!=o&&t.update(o),D(),r&&f(),s=window.history.state,j("page:change")},f=function(){var t,e,n,o,r,i,u,c,a,l,d,s;for(i=Array.prototype.slice.call(document.body.querySelectorAll('script:not([data-turbolinks-eval="false"])')),u=0,a=i.length;a>u;u++)if(r=i[u],""===(d=r.type)||"text/javascript"===d){for(e=document.createElement("script"),s=r.attributes,c=0,l=s.length;l>c;c++)t=s[c],e.setAttribute(t.name,t.value);e.appendChild(document.createTextNode(r.innerHTML)),o=r.parentNode,n=r.nextSibling,o.removeChild(r),o.insertBefore(e,n)}},D=function(){var t,e,n,o;for(e=Array.prototype.slice.call(document.body.getElementsByTagName("noscript")),n=0,o=e.length;o>n;n++)t=e[n],t.parentNode.removeChild(t)},R=function(t){return t!==L?window.history.pushState({turbolinks:!0,position:s.position+1},"",t):void 0},X=function(){var t,e;return(t=G.getResponseHeader("X-XHR-Redirected-To"))?(e=O(t)===t?document.location.hash:"",window.history.replaceState(s,"",t+e)):void 0},M=function(){return window.history.replaceState({turbolinks:!0,position:Date.now()},"",document.location.href)},q=function(){return s=window.history.state},C=function(t){return window.scrollTo(t.positionX,t.positionY)},K=function(){return window.scrollTo(0,0)},O=function(t){var e;return e=t,null==t.href&&(e=document.createElement("A"),e.href=t),e.href.replace(e.hash,"")},j=function(t){var e;return e=document.createEvent("Events"),e.initEvent(t,!0,!0),document.dispatchEvent(e)},N=function(){return!j("page:before-change")},H=function(){var t,e,n,o,r,i;return e=function(){var t;return 400<=(t=G.status)&&600>t},i=function(){return G.getResponseHeader("Content-Type").match(/^(?:text\/html|application\/xhtml\+xml|application\/xml)(?:;|$)/)},o=function(t){var e,n,o,r,i;for(r=t.head.childNodes,i=[],n=0,o=r.length;o>n;n++)e=r[n],null!=("function"==typeof e.getAttribute?e.getAttribute("data-turbolinks-track"):void 0)&&i.push(e.src||e.href);return i},t=function(t){var e;return k||(k=o(document)),e=o(t),e.length!==k.length||r(e,k).length!==k.length},r=function(t,e){var n,o,r,i,u;for(t.length>e.length&&(i=[e,t],t=i[0],e=i[1]),u=[],o=0,r=t.length;r>o;o++)n=t[o],_.call(e,n)>=0&&u.push(n);return u},!e()&&i()&&(n=l(G.responseText),n&&!t(n))?n:void 0},p=function(e){var n;return n=e.querySelector("title"),[null!=n?n.textContent:void 0,e.body,t.get(e).token,"runScripts"]},t={get:function(t){var e;return null==t&&(t=document),{node:e=t.querySelector('meta[name="csrf-token"]'),token:null!=e?"function"==typeof e.getAttribute?e.getAttribute("content"):void 0:void 0}},update:function(t){var e;return e=this.get(),null!=e.token&&null!=t&&e.token!==t?e.node.setAttribute("content",t):void 0}},n=function(){var t,e,n,o,r,i;e=function(t){return(new DOMParser).parseFromString(t,"text/html")},t=function(t){var e;return e=document.implementation.createHTMLDocument(""),e.documentElement.innerHTML=t,e},n=function(t){var e;return e=document.implementation.createHTMLDocument(""),e.open("replace"),e.write(t),e.close(),e};try{if(window.DOMParser)return r=e("<html><body><p>test"),e}catch(u){return o=u,r=t("<html><body><p>test"),t}finally{if(1!==(null!=r?null!=(i=r.body)?i.childNodes.length:void 0:void 0))return n}},b=function(t){return t.defaultPrevented?void 0:(document.removeEventListener("click",g,!1),document.addEventListener("click",g,!1))},g=function(t){var e;return t.defaultPrevented||(e=h(t),"A"!==e.nodeName||y(t,e))?void 0:(N()||Y(e.href),t.preventDefault())},h=function(t){var e;for(e=t.target;e.parentNode&&"A"!==e.nodeName;)e=e.parentNode;return e},d=function(t){return location.protocol!==t.protocol||location.host!==t.host},e=function(t){return(t.hash&&O(t))===O(location)||t.href===location.href+"#"},x=function(t){var e;return e=O(t),e.match(/\.[a-z]+(\?.*)?$/g)&&!e.match(/\.html?(\?.*)?$/g)},E=function(t){for(var e;!e&&t!==document;)e=null!=t.getAttribute("data-no-turbolink"),t=t.parentNode;return e},$=function(t){return 0!==t.target.length},A=function(t){return t.which>1||t.metaKey||t.ctrlKey||t.shiftKey||t.altKey},y=function(t,n){return d(n)||e(n)||x(n)||E(n)||$(n)||A(t)},w=function(){return M(),q(),l=n(),document.addEventListener("click",b,!0),window.addEventListener("popstate",function(t){var e;return e=t.state,(null!=e?e.turbolinks:void 0)?T[e.position]?m(e.position):Y(t.target.location.href):void 0},!1)},r=window.history&&window.history.pushState&&window.history.replaceState&&void 0!==window.history.state,o=!navigator.userAgent.match(/CriOS\//),P="GET"===B||""===B,r&&o&&P?(Y=function(t){return L=document.location.href,i(),v(t)},w()):Y=function(t){return document.location.href=t},this.Turbolinks={visit:Y,pagesCached:S}}).call(this),function(){}.call(this);