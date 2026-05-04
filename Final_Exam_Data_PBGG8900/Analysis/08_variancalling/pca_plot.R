library(ggplot2)

# Read PCA data
pca <- read.table("sweetgum_pca.eigenvec", header=FALSE)

# Rename columns
colnames(pca)[1:5] <- c("FID", "IID", "PC1", "PC2", "PC3")

# Plot PCA
ggplot(pca, aes(x=PC1, y=PC2)) +
    geom_point(size=3, color="blue") +
    theme_bw() +
    labs(
        title="PCA of Sweetgum Samples",
        x="Principal Component 1",
        y="Principal Component 2"
    )

# Save figure
ggsave("Sweetgum_PCA_plot.png", width=8, height=6)
