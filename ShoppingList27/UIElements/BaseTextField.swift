import SwiftUI

struct BaseTextField: View {
    
    @Binding var text: String
    let placeholder: String
    let hasError: Bool
    let errorText: String?
    var keyboardType: UIKeyboardType = .numberPad
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(placeholder, text: $text)
                    .tint(.uniTurquoise)
                    .font(.Body.regular)
                    .foregroundColor(.grey80)
                    .keyboardType(keyboardType)
                
                Button(action: {
                    text = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.hint)
                })
                .opacity(text.isEmpty ? 0 : 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.bgcolor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(hasError ? Color.uniRed : Color.clear, lineWidth: 0.5)
            )
            
            if hasError, let errorText = errorText {
                Text(errorText)
                    .font(.Footnote.regular)
                    .padding(.horizontal, 8)
                    .foregroundColor(.uniRed)
            }
        }
    }
}

#Preview {
    @Previewable @State var text1 = ""
    VStack(spacing: 20) {
        BaseTextField(
            text: $text1,
            placeholder: "Название списка",
            hasError: false,
            errorText: nil
        )
        BaseTextField(
            text: .constant("5"), // тут крестик работать не будет
            placeholder: "Количество",
            hasError: true,
            errorText: "Какая-то ошибка, пока не понятно в чем :)",
            keyboardType: .numberPad
        )
    }
    .padding()
    .background(Color.backgroundScreen)
}
