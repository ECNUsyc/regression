# 下载并调用所需包
if(!require(ggpubr)) install.packages("ggpubr")
if(!require(reshape2)) install.packages("reshape2")
if(!require(eoffice)) install.packages("eoffice")

library(ggpubr)
library(reshape2)
library(eoffice)

# 读取CSV文件
setwd("C:/Users/A/Desktop/ecnu/draft/regression")
data <- read.csv("traindata.csv")

# 将数据转换为长格式，适合绘制小提琴图
data1 <- melt(data, id.vars = "id")

# 创建小提琴图并赋值给对象p
p <- ggviolin(data1, x = "variable", y = "value",
              fill = "green",
              palette = c("#B3CDE3", "#DECBE4", "#F7E5C9"), # 设置颜色
              add = "boxplot", # 添加箱线图
              add.params = list(color = "white"), # 设置箱线图边颜色
              xlab = FALSE, # 不显示x轴的标签
              legend = "right" # 图例显示00在右侧
)

# 打印图形，确保图形成功生成
print(p)

# 保存绘图到PPT文件
doc <- read_pptx()  # 创建一个新的PowerPoint文档
doc <- add_slide(doc, layout = "Title and Content", master = "Office Theme")  # 添加幻灯片

# 使用dml()来插入ggplot图形
doc <- ph_with(doc, dml(code = print(p)), location = ph_location_fullsize())

# 保存PPT文件
print(doc, target = "1.pptx")