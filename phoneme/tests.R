# testing the logit on factors

cities <- c(rep("New York", 3), "Paris", "London", rep("Beijing", 2))
cities.factorized <- as.factor(cities)

n <- 1000

df <- data.frame(x = runif(n, 0, 5))
ProbabilityOfYGivenX <- function(x) {
    return((sin((x - 3) ^ 2) + 1.5) / 3)
}
df$y <- runif(n) < ProbabilityOfYGivenX(df$x)
df <- df[order(df$x), ]

dev.new(height=6, width=8)

plot(ProbabilityOfYGivenX, main="Some Hypothetical Data", xlab="x", ylab="y", type="l", xlim=c(0, 5), ylim=c(-0.1, 1.1), lwd=2)
points(df$x, df$y, col=rgb(0, 100, 0, 20, maxColorValue=255), pch=16, cex=1.5)
legend("topleft", "Pr[Y=1|X]", bty="n", lty=1)
legend("topright", "Observed Data", bty="n", pch=16, col=rgb(0, 100, 0, 100, maxColorValue=255), pt.cex=1.5)


# Define a factor that chops x into 20 disjoint buckets
df$f <- cut(df$x, breaks=c(-Inf, quantile(df$x, probs=((1:19)/20)), Inf))
# By construction we have (n / 20) = 50 observations in each bucket
summary(df$f)
logit.model <- glm(y ~ f, family=binomial("logit"), data=df)
df$y_hat <- predict(logit.model, newdata=df, type="response")

dev.new(height=6, width=8)

plot(ProbabilityOfYGivenX, main="Fun with Factors", xlab="x", ylab="y", type="l", xlim=c(0, 5), ylim=c(-0.1, 1.1), lwd=2)
points(df$x, df$y, col=rgb(0, 100, 0, 20, maxColorValue=255), pch=16, cex=1.5)
lines(df$x, df$y_hat, col="darkred", lty=2, lwd=1.5)
legend("topleft", "Pr[Y=1|X]", bty="n", lty=1)
legend("topright", "Observed Data", bty="n", pch=16, col=rgb(0, 100, 0, 100, maxColorValue=255), pt.cex=1.5)
legend("top", "Estimate of Pr[Y=1|X]", bty="n", lty=2, col="darkred")

