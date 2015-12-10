# Create a 28*28 matrix with pixel color values
m = matrix(unlist(train[10,-1]),nrow = 28,byrow = T)
# Plot that matrix
image(m,col=grey.colors(255))
#Rotate the images
#Why?
rotate <- function(x) t(apply(x, 2, rev)) # reverses (rotates the matrix)

# Plot a bunch of images
par(mfrow=c(2,3))
lapply(1:6, 
       function(x) image(
         rotate(matrix(unlist(train[x,-1]),nrow = 28,byrow = T)),
         col=grey.colors(255),
         xlab=train[x,1]
       )
)

par(mfrow=c(1,1)) # set plot options back to default
