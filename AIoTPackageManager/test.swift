import SwiftUI

struct DashboardView: View {
    // 規則 1：主色與副色
    let mainColor = Color.blue
    let subColor = Color.gray.opacity(0.8)
    
    // 規則 3：自適應平板大小的網格設定
    // 當螢幕寬度足夠（如 iPad），會自動將按鈕並排；在手機上則會維持單排
    let columns = [
        GridItem(.adaptive(minimum: 320, maximum: .infinity), spacing: 24)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // 使用 LazyVGrid 來取代原本的 VStack，達成自適應排版
                LazyVGrid(columns: columns, spacing: 24) {
                    
                    // 1. 上架包裹
                    MenuButton(
                        title: "上架包裹",
                        subtitle: "新增包裹並綁定底層重量感測器",
                        iconName: "shippingbox.fill",
                        mainColor: mainColor,
                        subColor: subColor
                    )
                    
                    // 2. 查看住戶
                    MenuButton(
                        title: "查看住戶",
                        subtitle: "管理社區住戶名單與領取權限",
                        iconName: "person.2.fill",
                        mainColor: mainColor,
                        subColor: subColor
                    )
                    
                    // 3. 查看架子
                    MenuButton(
                        title: "查看架子",
                        subtitle: "監控無櫃式層架的即時重量與空間",
                        iconName: "square.grid.3x2.fill",
                        mainColor: mainColor,
                        subColor: subColor
                    )
                    
                }
                .padding(.horizontal, 24) // 增加外距，讓平板在大螢幕下視覺更集中
                .padding(.top, 24)
            }
            .navigationTitle("包裹管理")
            .toolbar {
                // 右上角的管理員頭像
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // 管理員個人檔案或設定
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40) // 符合觸控熱區規範
                            .foregroundStyle(mainColor)
                            .background(Circle().fill(Color(UIColor.systemBackground)))
                            .overlay(
                                Circle().stroke(subColor.opacity(0.5), lineWidth: 1)
                            )
                    }
                }
            }
            // 讓平板的導覽列背景更自然
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        }
    }
}

// 規則 2 & 3：符合 HIG 理念且支援自適應大小的卡片元件
struct MenuButton: View {
    let title: String
    let subtitle: String
    let iconName: String
    let mainColor: Color
    let subColor: Color
    
    var body: some View {
        Button(action: {
            // 導航動作
        }) {
            HStack(spacing: 16) {
                // 左側圖示區塊
                Image(systemName: iconName)
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                // 中間文字區塊：使用 alignment: .leading 確保無論卡片多寬，文字都靠左對齊
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(subColor)
                        // 讓副標題最多顯示兩行，避免平板上過度展開或手機上被截斷
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 0) // 推擠空間，讓卡片內容填滿
                
                // 右側箭頭指示
                Image(systemName: "chevron.right")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(subColor.opacity(0.6))
            }
            .padding(20)
            // maxWidth: .infinity 確保按鈕在 Grid 裡面會彈性撐開
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        // 增加點擊時的微小縮放回饋，提升 HIG 要求的操作手感 (Fluid Interface)
        .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    DashboardView()
}
