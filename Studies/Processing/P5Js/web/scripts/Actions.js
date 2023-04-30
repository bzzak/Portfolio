const blurMatrix = [ [ 1.0/9.0, 1.0/9.0, 1.0/9.0 ],
                     [ 1.0/9.0, 1.0/9.0, 1.0/9.0 ],
                     [ 1.0/9.0, 1.0/9.0, 1.0/9.0 ] ];
                     
const brightMatrix = [ [ 0, 0  , 0 ],
                       [ 0, 1.5, 0 ],
                       [ 0, 0  , 0 ] ];

function blur()
{
    if(mouseStartX == 0 && mouseStartY == 0 && mouseEndX == 0 && mouseEndY == 0)
    {
        for (let y = 0; y < workingCopy.height; y++) 
        {   
            for (let x = 0; x < workingCopy.width; x++) 
            {  
                let sumRed = 0;   
                let sumGreen = 0;
                let sumBlue = 0;
                for (let ky = -1; ky <= 1; ky++) 
                {
                    for (let kx = -1; kx <= 1; kx++) 
                    {
                        let pos = (y + ky) * workingCopy.width + (x + kx);
                        pos *= 4;
                        sumRed += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos];
                        sumGreen += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 1];
                        sumBlue += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 2];
                    }
                }
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = sumRed;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 1] = sumGreen;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 2] = sumBlue;
            }
        }
    }
    else
    {
        for (let y = Math.trunc(mouseStartY); y < Math.trunc(mouseEndY); y++) 
        {   
            for (let x = Math.trunc(mouseStartX); x < Math.trunc(mouseEndX); x++) 
            {  
                let sumRed = 0;   
                let sumGreen = 0;
                let sumBlue = 0;
                for (let ky = -1; ky <= 1; ky++) 
                {
                    for (let kx = -1; kx <= 1; kx++) 
                    {
                        let pos = (y + ky) * workingCopy.width + (x + kx);
                        pos *= 4;
                        sumRed += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos];
                        sumGreen += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 1];
                        sumBlue += blurMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 2];
                    }
                }
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = sumRed;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 1] = sumGreen;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 2] = sumBlue;
            }
        }
    }
    workingCopy.updatePixels();
}


function bright()
{
    if(mouseStartX == 0 && mouseStartY == 0 && mouseEndX == 0 && mouseEndY == 0)
    {
        for (let y = 0; y < workingCopy.height; y++) 
        {   
            for (let x = 0; x < workingCopy.width; x++) 
            {  
                let sumRed = 0;   
                let sumGreen = 0;
                let sumBlue = 0;
                for (let ky = -1; ky <= 1; ky++) 
                {
                    for (let kx = -1; kx <= 1; kx++) 
                    {
                        let pos = (y + ky) * workingCopy.width + (x + kx);
                        pos *= 4;
                        sumRed += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos];
                        sumGreen += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 1];
                        sumBlue += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 2];
                    }
                }
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = sumRed;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 1] = sumGreen;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 2] = sumBlue;
            }
        }
    }
    else
    {
        for (let y = Math.trunc(mouseStartY); y < Math.trunc(mouseEndY); y++) 
        {   
            for (let x = Math.trunc(mouseStartX); x < Math.trunc(mouseEndX); x++) 
            {  
                let sumRed = 0;   
                let sumGreen = 0;
                let sumBlue = 0;
                for (let ky = -1; ky <= 1; ky++) 
                {
                    for (let kx = -1; kx <= 1; kx++) 
                    {
                        let pos = (y + ky) * workingCopy.width + (x + kx);
                        pos *= 4;
                        sumRed += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos];
                        sumGreen += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 1];
                        sumBlue += brightMatrix[ky + 1][kx + 1] * workingCopy.pixels[pos + 2];
                    }
                }
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = sumRed;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 1] = sumGreen;
                workingCopy.pixels[((y * workingCopy.width + x) * 4) + 2] = sumBlue;
            }
        }
    }
    workingCopy.updatePixels();
}


function gray()
{
    if(mouseStartX == 0 && mouseStartY == 0 && mouseEndX == 0 && mouseEndY == 0)
    {
        //print("Im filtering grayscale!\n")
        workingCopy.filter(GRAY);
    }
    else
    { 
        const imageCopy = createImage(workingCopy.width, workingCopy.height);
        imageCopy.copy(workingCopy, 0, 0, workingCopy.width, workingCopy.height, 0, 0, workingCopy.width, workingCopy.height );
        imageCopy.filter(GRAY);
        imageCopy.loadPixels();
        
        for (let y = Math.trunc(mouseStartY); y < Math.trunc(mouseEndY); y++) 
        {   
            for (let x = Math.trunc(mouseStartX); x < Math.trunc(mouseEndX); x++) 
            {  
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = imageCopy.pixels[(y * workingCopy.width + x) * 4];
                workingCopy.pixels[(y * workingCopy.width + x) * 4 + 1] = imageCopy.pixels[(y * workingCopy.width + x) * 4 + 1];
                workingCopy.pixels[(y * workingCopy.width + x) * 4 + 2] = imageCopy.pixels[(y * workingCopy.width + x) * 4 + 2];
            }
        }
        workingCopy.updatePixels();
    }
    //workingCopy.updatePixels();
}


function restore()
{
    if(mouseStartX == 0 && mouseStartY == 0 && mouseEndX == 0 && mouseEndY == 0)
    {
        workingCopy.copy(oryginal, 0, 0, workingCopy.width, workingCopy.height, 0, 0, workingCopy.width, workingCopy.height);
        workingCopy.loadPixels();
    }
    else
    {
        for (let y = Math.trunc(mouseStartY); y < Math.trunc(mouseEndY); y++) {   
            for (let x = Math.trunc(mouseStartX); x < Math.trunc(mouseEndX); x++) {  
                workingCopy.pixels[(y * workingCopy.width + x) * 4] = oryginal.pixels[(y * workingCopy.width + x) * 4];
                workingCopy.pixels[(y * workingCopy.width + x) * 4 + 1] = oryginal.pixels[(y * workingCopy.width + x) * 4 + 1];
                workingCopy.pixels[(y * workingCopy.width + x) * 4 + 2] = oryginal.pixels[(y * workingCopy.width + x) * 4 + 2];
            }
        }
    }
    workingCopy.updatePixels();
}
