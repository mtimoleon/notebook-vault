**Polling**  
==Now polling is a slightly better option if the user wants to use the application while the data is loading and you don====’====t have that much time to invest in the solution and/or your backend is not providing you with WebSockets then polling is the way to go.==  
==Polling means checking the status of (a backend endpoint in this case ), especially as part of a repeated cycle. Translating it to front-end language means making a get request every few seconds to see if the asynchronous task is finished. For backend that would mean creating a new GET endpoint that would return the calculated data. (if in fact it has been calculated before)==  
==Not the most elegant solution out there but still pretty usable!==  
**HOW:**  
==We make one POST request that informs the backend to start the calculations and one more GET request to get the output data.==  
==One of the ways of polling is combining RxJs====’====s== _timer_ ==with== _switchMap_==. Also remember to unsubscribe, because all sorts of intervals can easily produce memory leaks, in this example, we are using== _takeUntil_ ==operator that unsubscribes from the observable when it====’====s component is destroyed.==  
**EXAMPLE:**
 
==timer(0, 5000).pipe( switchMap(() =\> this.truckService.getLoadedTrucks()), takeUntil(this.stopPolling) )====￼==
 \> From \<[https://inero-software.com/angular-how-to-manage-back-end-long-running-asynchronous-tasks/](https://inero-software.com/angular-how-to-manage-back-end-long-running-asynchronous-tasks/)\>     

**Websockets**  
==Websocket is a communication protocol (just like HTTP)== ==“====for a persistent, bi-directional, full duplex TCP connection from a user====’====s web browser to a server====”====. Basically what it means is that with WebSockets you can send out the data from the server and receive it in your frontend application without making any unnecessary requests (like you would using polling).==  
==With the Websocket approach, you would send an HTTP POST request to start calculating the truckload. And at the same time, you would establish a WebSocket connection between the Frontend application and the server so that when the backend tasks finish the output is sent through that WebSocket connection.==  
**HOW:**  
==Send HTTP POST request that informs the backend to start the calculations and listen on Websocket connection with a backend that returns data when the calculations finish==  
**EXAMPLE:**  
==At first, you connect to a WebSocket:==  
==public connect() {====￼====const socket = new== **WebSocket**==(this.webSocketUri);====￼====this.stompClient = Stomp.over(socket);====￼====this.stompClient.connect({},====￼====() =\> this.subscribe()====￼====}====￼==  
==And later on, you subscribe to its values:==  
==this.stompClient.subscribe('/user/queue/truck-load-updates-queue', (msg: Stomp.Frame) =\> {====￼====const msgBody === **JSON**==.parse(msg.body);====￼====...====￼====});====￼==  
==The subscription above is triggered after the calculation is done.==
 \> From \<[https://inero-software.com/angular-how-to-manage-back-end-long-running-asynchronous-tasks/](https://inero-software.com/angular-how-to-manage-back-end-long-running-asynchronous-tasks/)\>