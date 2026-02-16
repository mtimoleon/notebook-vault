---
categories:
  - "[[Work]]"
created: 2023-06-16
product:
component:
tags: []
---

Advanced user:

- Create a project
- Place a bid

Basic user  
Create a project
 
Bids: only by organization or user if he does not have organization. If a user wants to bid and there is another bid for the specific organization (maybe from a different user) then user can only edit or withdraw. This means that we need to link bids with organizations.  
Projects: a project can be setup as personal or under organization  
Add user role in header  
When user logs in we should return all related labs ? So he can choose a role to use afterwards or every time he performs an action ask the relative role for that action  
A user is registered and wants to be advanced, so he should add organization data  
Any user who is under an organization can add another user with email under the same organization. Then a link for registration under the specific organization is generated.  
A user cannot belong to more than one organization  
User is already registered, can someone add him to organization?

|   |
|---|
|```<br>    public async Task AddBidToProjectAsync(User user, int projectId, BidDto bidDto,__  <br>                CancellationToken cancellationToken)  <br>            {  <br>                var project = await _context.Projects  <br>                    .Include(p =\> p.ProjectStatus)  <br>                    .SingleOrNotExistsAsync(p =\> p.Id == projectId  <br>                                                 && p.UserId != user.Id  <br>                                                 && p.ProjectStatus == ProjectStatus.Active, cancellationToken);  <br>      <br>                var bid = _mapper.Map\<Bid\>(bidDto);  <br>                bid.BidStatus = _context.BidStatuses.Single(bs =\> bs == BidStatus.Pending);  <br>                bid.User = user;  <br>                project.Bids.Add(bid);  <br>                await _context.SaveChangesAsync(cancellationToken);  <br>                return _mapper.Map\<BidDetailDto\>(bid);  <br>            }<br>```|

![Exported image](Notes-20260217.bmp)