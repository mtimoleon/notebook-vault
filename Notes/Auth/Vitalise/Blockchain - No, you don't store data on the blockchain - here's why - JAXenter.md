---
categories:
  - "[[Work]]"
created: 2021-10-20
product:
component:
tags: []
---

Clipped from: [https://jaxenter.com/blockchain-data-164727.html](https://jaxenter.com/blockchain-data-164727.html)

![Exported image](Exported%20image%2020260211205154-0.jpeg)

© Shutterstock / Visual Generation (modified)  
Blockchain is going through a lot of growing pains and there’s a lot of hidden costs that come along with it. Blockchain won’t be able to disrupt any real-world industry unless the problem of data storage is resolved. What are the alternatives? Some of them are more decentralized than others, some are cheaper than others – but they all work.  
Blockchain is supposed to transform just about every industry – from healthcare to education. But behind all the talk of “immutable records” and “trustless storage of data” there’s a big caveat. Where will all that data go?

## The hidden cost

It’s tempting to imagine a future where nobody can tamper with our healthcare records, insurance policies, or marketplace reviews. In this bright new world, all sensitive data is magically stored on a blockchain and remains there forever – for free, apparently.  
Here are just a couple of examples:

![blockchain](Exported%20image%2020260211205155-1.png)

![blockchain](Exported%20image%2020260211205158-2.png)

Credits: Surety.ai

However, blockchain projects making such bold claims usually forget to mention a crucial detail. Storing any serious amount of data on a public blockchain like Ethereum is very, very expensive. Let’s see how much it really costs to put an insurance policy on the blockchain, for instance.  
The vast majority of blockchain startups still cling to Ethereum and its ERC20 token standard. This means that you’d have to pay for gas whenever you transact on their platforms.  
Ethereum’s [Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) states that it costs 20 000 gas to store one 256-bit word. Now, let’s do some math. Eight bit make one byte, so one word is 32 byte. 1024 byte make one kilobyte. So the amount of gas you’d pay to store 1 kilobyte equals 32*20 000 gas=640 000 gas. The price of gas in ETH isn’t fixed, though: users can set their own. According to [ETH Gas Station](https://ethgasstation.info/), the average price as of November 2019 is 6 gwei, or 0.000006 ETH. Thus, to store just 1 kilobyte of data you’d pay on average 640 000 gas*0.000006 ETH = 0.00384, or $0.73 at the current ETH/USD price.  
That’s just one kilobyte, though. Let’s say an average insurance policy document weights 1 MB. To store that amount of data, you’d pay $0.73*1024 = $747.52. Whoops! That’s way too much. And let’s not forget that you’ll have to pay every time you read that data, too.  
Another issue is the time it takes to write data to the Ethereum blockchain. There’s a limit on how much gas people can spend on the transactions in each block. This limit is currently set at 10 million gas. We’ve seen that it takes 640 000 gas per kilobyte – and that makes over 655 million gas per megabyte. Therefore, it would require 66 blocks to record the whole file. At the average block time of 13 seconds, you’d need to wait for over 14 minutes to save just 1 MB.

![Blockchain Whitepaper 2019](Exported%20image%2020260211205201-3.jpeg)

### **Free: Blockchain Technology Whitepaper 2019**

If building a blockchain from scratch is beyond your current scope, the blockchain technology whitepaper is worth a look. Experts from the field share their know-how, tips and tricks, development advice, and strategy for becoming a blockchain master.

## What are the alternatives?

Ethereum wasn’t designed to store any other records but simple transactions. An average payment on the blockchain takes up about 100 bytes – that’s why transaction fees are so low.  
Storing things like contracts, policies, or reviews on a public distributed ledger like Ethereum is unrealistic. Whenever you see such a claim coming from a blockchain startup, an alarm signal should go off in your head. Are they trying to fool you? Or perhaps the founders themselves don’t know how the system works?  
There are several solutions to the problem, though. Some of them are more decentralized than others, some are cheaper than others – but they all work.  
**SEE ALSO:** **Women in Tech: “Accept opportunities, know your worth, and find mentors”**

## 1) Centralized storage + blockchain hashes.

In this scenario, a platform stores content on a traditional server rented from a hosting company. But whenever a new document is added to the system, a transaction is recorded on the blockchain, and the document gets its own unique hash. This is the most realistic method for now, since true distributed storage systems are still in their infancy.  
2) P2P data sharing networks.  
Examples include [IPFS](https://ipfs.io/) (Interplanetary File Storage System), [Swarm](https://swarm-guide.readthedocs.io/en/latest/index.html#), and [Arweave](https://www.arweave.org/). In such systems, files are stored on individual users’ servers and drives. Each file is addressed by its unique hash and can be stored in many copies across the network. Like in Bittorrent, you can receive data from many nodes at once, so even if some of them malfunction, your data will remain accessible.

![blockchain](Exported%20image%2020260211205204-4.png)

Credits: blog.cloudflare.com

IPFS is already operational and completely free, at least for now. However, it’s not reliable enough to store sensitive data. It definitely can’t compete with the leading hosting providers, which offer [99.95%+ uptime](https://www.hrank.com/providers) and a response time below 0.5 seconds.  
Swarm and Arweave promise to be fast and very cheap. But they are still in the early stages of development. It will take years before they can be used in such industries as insurance and education.

## 3) Permissioned (private) blockchains

Whoever creates a blockchain sets their own fees. Instead of using Ethereum, you can design your own distributed ledger and set data storage fees to zero. In that case, you can save all the files you want – for free. However, there are [downsides to private blockchains](https://blocksdecoded.com/public-private-blockchains/):

- **Centralization**: the creators of a private blockchain retain full control over it. It’s very far from the middlemen-free ideal of blockchain enthusiasts.
- **Less secure**: since there are fewer nodes to validate transactions, a private blockchain is less resistant to hacker attacks, abusive behavior by nodes, etc.
- **Scaling**: new nodes can’t freely join the network, so it will take longer for a private blockchain to grow.
- **Lack of trust**: users might not be willing to entrust their records to a platform if they have zero control or role in the blockchain.

**SEE ALSO:** **In Focus: Code Generation**

## In conclusion

Blockchain won’t be able to disrupt any real-world industry unless the problem of data storage is resolved. Distributed ledgers weren’t originally created to manage supermarket supply lines or agricultural loans. But on the other hand, nobody thought of smart phones when LED screens were invented.  
Blockchain technology is going through major growing pains right now, and a solution will surely be found.  
What will it be?  
An incredibly fast P2P data network?  
A new blockchain-derived technology, like Arweave’s blockweave?  
Or perhaps private [blockchains operating in a cloud](https://jaxenter.com/blockchain-cloud-interview-kuhlman-153287.html)?  
Time will tell. For now, remember: if a startup promises to store vast amounts of records on the blockchain, you should take that claim with a large grain of salt.