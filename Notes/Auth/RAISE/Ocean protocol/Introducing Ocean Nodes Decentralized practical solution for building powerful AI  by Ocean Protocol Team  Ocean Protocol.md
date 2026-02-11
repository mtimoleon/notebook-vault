Clipped from: [https://blog.oceanprotocol.com/introducing-ocean-nodes-decentralized-practical-solution-for-building-powerful-ai-c72fc6747165](https://blog.oceanprotocol.com/introducing-ocean-nodes-decentralized-practical-solution-for-building-powerful-ai-c72fc6747165)

[![Ocean Protocol Team](Exported%20image%2020260211205125-0.png)](https://medium.com/@TeamOcean?source=post_page---byline--c72fc6747165---------------------------------------)

## This blogpost will detail how Ocean Nodes work, the benefits they bring to the community, our launch roadmap, incentives for participation, and opportunities for early adopters.

![ocean nodes the Ocean tech stack](Exported%20image%2020260211205126-1.png)

We’re thrilled to share some exciting news from Ocean Protocol. After months of development and community feedback, we are launching [Ocean Nodes](https://github.com/oceanprotocol/ocean-node) — a powerful, decentralized solution to streamline and enhance your AI model development. Ocean Nodes is designed to simplify the process of leveraging Ocean Protocol’s capabilities, making it easier than ever to build, deploy, and monetize AI models.  
AI technology is everywhere. Machine learning models have been integrated into our lives for some time now — it’s in our smartphones (camera image processing, keyboard autocomplete, etc.), search engines, transportation apps, and more. While these technologies have been seamlessly integrated into our lives, using them to simplify our day-to-day tasks, recent advancements like OpenAI’s generative pre-trained transformer (GPT) have brought ML into the spotlight. Now, other major players are investing heavily in these solutions.  
So we are taking it one step further, with **an innovative solution to democratize** these large models, **decentralize** them, and help **monetize and protect IP**: **Ocean Nodes****.**  
This launch is a significant milestone for us, aligning perfectly with our broader goals for 2024. As highlighted in our [roadmap](https://blog.oceanprotocol.com/ocean-protocol-update-2024-e463bf855b03#d8a4), specifically the goal to launch C2D.2, Ocean Nodes are the foundation for achieving scalable Compute-to-Data (C2D) technology.  
This blogpost will detail how Ocean Nodes work, the benefits they bring to the community, our launch roadmap, incentives for participation, and opportunities for early adopters.

# **The Ocean Nodes**

Ocean Nodes have been designed to provide the developer community with a smoother experience, whilst introducing a way to monetize independent computational resources through its infrastructure. It allows individuals to run all components of the Ocean Protocol stack such as _Ocean Provider, Aquarius and Compute-to-Data_, in a single component — effectively simplifying the process of using Ocean to manage data sharing on decentralized rails. On top of this, any GPU provider will soon be able to share & monetize their computational resources directly via Ocean Protocol — ultimately lowering the barrier to entry for everyone to participate in the new data economy.  
The launch of the Ocean Nodes marks a significant step for developers, data scientists and large organizations interested in running computation directly on-chain whilst demanding reliability and scalability of traditional Web2 infrastructure — all whilst keeping privacy as a first-class citizen.  
We created this component with a modular approach in mind. You can install it and run it just as a provider, with minimal resources needed, or you can run the full node with indexer and C2D.  
**Benefits for the Ocean Nodes User**

- **Simplified Workflow**: Run all essential components of the Ocean Protocol stack, such as Ocean Provider, Aquarius, and Compute-to-Data, in a **single setup**
- **Monetization Opportunities**: Easily monetize independent computational resources
- **Enhanced Privacy**: Prioritize privacy with advanced encryption features
- **Scalability**: Benefit from a scalable solution that integrates seamlessly with existing infrastructure
- **Ease of Use**: Designed to be user-friendly with a modular approach for flexibility
- **Early Adopter Rewards**: Exclusive incentives and rewards for early participants

# **Launch roadmap**

We value the power of community feedback, so instead of waiting for the final version, we are implementing a three-stage release to gather your valuable insights and improve the product as we go.

## **Phase 1 — A new beginning**

The first stage is all about creating a vertically and horizontally scalable component that integrates all previous off-chain elements, making it easy for developers to run the Ocean infrastructure.

![TOOLS Ocean CLI vs code DAPPS dApp A OCEAN NODE NE...](Exported%20image%2020260211205129-2.png)

## **Phase 2 — Decentralized Encryption**

Expected in Q3 2024, this phase will introduce advanced privacy features through an integration with [Oasis Protocol](https://oasisprotocol.org/). In this release the Ocean Provider will be run using the [Oasis Sapphire](https://oasisprotocol.org/sapphire) SDK for asset encryption and decryption, enhancing node security and trust.

![TOOLS Ocean CLI vs code DAPPS dApp A Tool n OCEAN ...](Exported%20image%2020260211205130-3.png)

Previously, encryption relied on a private key on the desired Ocean Provider, which (1) required trusting the provider and (2) if that provider went down, the user would have had to republish the asset with a new provider. With the new system, encryption is handled by Oasis Sapphire, eliminating dependency on specific nodes.  
We have mitigated trust issues by making nodes easy to install with minimal resources and by introducing a new way of setting trusted nodes using NFTs. Anyone can create a trust list, and only nodes on that list can decrypt and serve the asset, ensuring enhanced security and reliability.

## **Phase 3 — Scalable Compute-to-Data Technology**

The final release of Ocean Nodes will include a full refactoring of the Compute-to-Data technology, which will enable computation on data sources hosted on traditional data infrastructures.  
This enhancement allows the Ocean Protocol infrastructure to scale horizontally beyond Web3, empowering traditional Web2 organizations to save costs, maintain their existing infrastructure whilst benefiting from the permissionless, verifiability, immutability, and privacy features offered by Ocean.  
Compute-to-Data 2.0 (C2D.2) will be an additional component provided by Ocean Nodes, and will also allow everyone to monetize their idle computing power by offering CPU/GPU resources.

![TOOLS vs code Ocean CLI OCEAN NODE NETWORK OCEAN N...](Exported%20image%2020260211205131-4.png)

# **Incentives — starting August 29nd, 2024**

We will have multiple incentive mechanisms during the lifetime of the nodes to help grow a sustainable ecosystem. These incentive mechanisms will change and evolve during time depending on the needs.  
The first will be based on uptime.  
The Ocean Protocol Foundation will allocate 5,000 $FET each week to Ocean Nodes that demonstrate a high level of uptime. Rewards will be calculated weekly using the formula:  
_R0 = Xt * U0 / Ut_  
Where:

- R0 = Total Rewards earned
- Xt = Total Rewards available
- U0 = Node Uptime in seconds
- Ut = Total Uptime per week, in seconds

To prevent network exploitation by malicious actors, the OPF Benchmark Backend will regularly monitor and record node uptime on the [dedicated dashboard](http://nodes.oceanprotocol.com/). More details about the incentives in the [dedicated blog post](https://blog.oceanprotocol.com/ocean-nodes-incentives-a-detailed-breakdown-0baf8fc98001).

## **Early adopters**

As Ocean Protocol remains committed to reward early adopters, we invite you to join us in the first month of each phase launch to receive exclusive Soulbound Tokens (SBTs) for nodes with the highest uptime.  
A maximum of 50 nodes will be awarded one SBT per stage. These tokens will offer a reward multiplier and will be awarded to Ocean Nodes who remain active throughout each launch stage.  
Owning all three SBTs will grant **a maximum reward multiplier of 2x**. Owning fewer than three SBTs will follow the structure below:

- **Phase 1 Launch SBT: 1.5x Reward Multiplier**
- **Phase 2 Launch SBT: 1.3x Reward Multiplier**
- **Phase 3 Launch SBT: 1.2x Reward Multiplier**

Our team has designed Ocean Nodes to be both user-friendly and powerful, addressing the needs of developers, data scientists, and organizations. With Ocean Nodes, you can now run all essential components of the Ocean Protocol stack in a single, streamlined setup. This not only simplifies your workflow but also opens up new opportunities for monetizing computational resources.  
By getting started with Ocean Nodes now, you’ll be well-prepared to leverage the full potential of C2D as it evolves, ensuring you stay ahead in the rapidly changing landscape of AI and data sharing.  
To start running your node today access the Ocean Nodes [README](https://github.com/oceanprotocol/ocean-node), and follow the [Quickstart guide](https://github.com/oceanprotocol/ocean-node/tree/main/deployment) available in the main repository for detailed instructions on deployment.  
For more updates and detailed guides on setting up and running your nodes follow us on our dedicated [X](https://x.com/OceanDevRel) profile, and join the discussion in our Discord Server.