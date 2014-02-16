ShortBus.Scaffolding
====================

Scaffolding templates for the ShortBus mediator library

To use:

Open up the package manager console. By default, requests and notifications are stored in:

> \Mediator\Requests  
> \Mediator\Requests\Handlers  
> \Mediator\Notifications  
> \Mediator\Notifications\Handlers  

You can changet his with the -DefaultDirectory option


### Scaffolding a request

```bash
Scaffold ShortBus-Request GetUser User
```

### Scaffolding a notification

```bash
Scaffold ShortBus-Request GetUser User
```

### Specifying a different directory to store files

```bash
Scaffold ShortBus-Request GetUser User -DefaultDirectory Queries
```
