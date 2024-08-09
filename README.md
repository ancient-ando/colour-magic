# colour-magic
**“Color Magic”** is an artistic oil paint blending tool created by and for artists. It is available for **free** use under an MIT license. The tool aims to bridge the gap between physical painting and digital painting. **While it is based on optics and my extensive research, it doesn’t precisely mimic real-life paint behaviour.** Creative adjustments have been made to the algorithm to enhance the gradient and achieve a more realistic appearance.

Unlike other available libraries, we make it possible to blend **any numbers of any base colour** (selected from a given set of colours) in an **efficient and convincing** manner. 

![banner](https://github.com/user-attachments/assets/9853ac23-cdff-4b9d-89ca-309b9f434f94)

Special thanks to **Sion** for technical support. 

## Usage
Please check [colour_magic.shader](https://github.com/ancient-ando/colour-magic/blob/main/colour_magic.shader)

## Long Long Ago 

I began this project while reflecting on my oil painting and wondering why I couldn’t recreate it digitally. I soon realized the challenges involved. **The Kubelka-Munk (KM) theory is commonly used for colour blending in industry, but it has its limitations.** 

$$\frac{(1-R_{\infty})^2}{2R_{\infty}} = \frac{a_{0}}{r_{0}} = \frac{K}{S} = \frac{\sum (c_{i}K_{i})}{\sum(c_{i}S_{i})} \approx \frac{\sum (c_{i}K_{i})}{S}$$

We define 
- K - the absorption coefficients
- S - the back-scattering coefficients
- R_inf - the reflection coefficients of an infinite thick paint, can be measured with a spectrophotometer.

This linear formula may not fully capture the intricate behaviour of pigments in reality. Additionally, the KM theory has been proven to be flawed in certain situations, such as when one pigment concentration overwhelms another. 

**In other words, if you ask the algorithm what you will get, blending 99.99% or even 100% blue and 0.01% (0%) yellow, for example, you are likely to get an answer that is not blue.** 

That does not sound good, right? 

**Nontheless, I am by no means a physicist/material scientist, so I had to find a creative (artistic) workaround here.**

## The Shortcut
$$ \frac{1}{R_{\infty }} \approx \sum \frac{c_{i}}{R_{i}} $$

## Showcase
![Showcase](https://github.com/user-attachments/assets/a171d009-a018-4d0f-b18f-3ec981b9299a)



