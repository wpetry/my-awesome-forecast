gflu <- read.csv("http://www.google.org/flutrends/about/data/flu/us/data.txt",
                 skip =11)

y <- ts(gflu$Massachusetts)
arima_model <- arima(y, order = c(3, 0, 1))
forecast <- predict(arima_model, n.ahead = 10)

# store plot
jpeg("forecast_plot.jpg")
plot(y, type = "l", ylab = "Flu Index", lwd = 2, xlim = c(540, 640),
     ylim = c(0, 4000))
lines(forecast$pred, lwd = 2, col = "dodgerblue2")
dev.off()

# store predictions themselves
predictions <- data.frame(time = time(forecast$pred),
                          prediction = forecast$pred,
                          stde = forecast$se)
write.csv(predictions, "predictions.csv", row.names = FALSE)
