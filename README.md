# colour-magic
**“Color Magic”** is an artistic oil paint blending tool created by and for artists. It is available for **free** use under an MIT license. The tool aims to bridge the gap between physical painting and digital painting. **While it is based on optics and my extensive research, it doesn’t precisely mimic real-life paint behaviour.** Creative adjustments have been made to the algorithm to enhance the gradient and achieve a more realistic appearance.

Unlike other available libraries, we make it possible to blend **any numbers of any base colour** (selected from a given set of colours) in an **efficient and convincing** manner. 

![banner](https://github.com/user-attachments/assets/9853ac23-cdff-4b9d-89ca-309b9f434f94)

I began this project while reflecting on my oil painting and wondering why I couldn’t recreate it digitally. I soon realized the challenges involved. **The Kubelka-Munk (KM) theory is commonly used for colour blending in industry, but it has its limitations.** 

![d193608a58eb4a8719d55927c53a363245843c34](https://github.com/user-attachments/assets/5980dde0-58d7-4ec0-8b4c-824677cc6d7c)

We define 
- K - absorption coefficients
- S - back-scattering coefficients
- R_inf - can be measured with a spectrophotometer.

This linear formula may not fully capture the intricate behaviour of pigments in reality. Additionally, the KM theory has been proven to be flawed in certain situations, such as when one pigment concentration overwhelms another. 

**In other words, if you ask the algorithm what you will get, blending 99.99% or even 100% blue and 0.01% (0%) yellow, for example, you are likely to get an answer that is not blue.** 

That does not sound good, right? 

**However, I am by no means a physicist/material scientist, so I had to find a creative (artistic) workaround here.**

