import SwiftUI

// MARK: - BaseTextField

struct BaseTextField: View {
    
    @Binding var text: String
    private let titleKey: String
    private let placeholder: String
    private let errorText: String?
    private let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(titleKey, text: $text, prompt: Text(placeholder))
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
                    .stroke(errorText == nil ? Color.clear : Color.uniRed,
                            lineWidth: 0.5)
            )
            
            if let errorText {
                Text(errorText)
                    .font(.Footnote.regular)
                    .padding(.horizontal, 8)
                    .foregroundColor(.uniRed)
            }
        }
    }
    
    // MARK: Initializer
    
    init<F>(
        _ titleKey: String,
        value: Binding<F.FormatInput?>,
        format: F,
        placeholder: String,
        errorText: String? = nil,
        keyboardType: UIKeyboardType = .default
    ) where F: ParseableFormatStyle, F.FormatOutput == String {
        self.titleKey = titleKey
        let adapterBinding = Binding<String>(
            get: {
                if let value = value.wrappedValue {
                    format.format(value)
                } else {
                    ""
                }
            }, set: { str in
                value.wrappedValue = try? format.parseStrategy.parse(str)
            })
        self._text = adapterBinding
        self.placeholder = placeholder
        self.errorText = errorText
        self.keyboardType = keyboardType
    }
    
    init(
        text: Binding<String>,
        placeholder: String,
        hasError: Bool,
        errorText: String?,
        keyboardType: UIKeyboardType = .default
    ) {
        self.titleKey = placeholder
        self._text = text
        self.placeholder = placeholder
        if hasError, let errorText {
            self.errorText = errorText
        } else {
            self.errorText = nil
        }
        self.keyboardType = keyboardType
    }
    
    init(
        _ titleKey: String,
        text: Binding<String>,
        placeholder: String,
        errorText: String? = nil,
        keyboardType: UIKeyboardType = .default
    ) {
        self.titleKey = titleKey
        self._text = text
        self.placeholder = placeholder
        self.errorText = errorText
        self.keyboardType = keyboardType
    }
}

// MARK: - Preview - OldTextInit

#Preview("OldTextInit") {
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
            keyboardType: .default
        )
    }
    .padding()
    .background(Color.backgroundScreen)
    .onChange(of: text1) { _, newValue in
        print(newValue)
    }
}

// MARK: - Preview - NewTextInit

#Preview("NewTextInit") {
    @Previewable @State var text = "Hello world"
    VStack(spacing: 20) {
        BaseTextField(
            "Text",
            text: $text,
            placeholder: "Текст",
            keyboardType: .default
        )
        BaseTextField(
            "Text",
            text: .constant("5"), // тут крестик работать не будет
            placeholder: "Текст",
            errorText: "Какая-то ошибка, пока не понятно в чем :)",
            keyboardType: .default
        )
    }
    .padding()
    .background(Color.backgroundScreen)
    .onChange(of: text) { _, newValue in
        print(newValue)
    }
}

#Preview("OptionalValueInit") {
    @Previewable @State var value: Int? = 10
    VStack(spacing: 20) {
        BaseTextField(
            "Value",
            value: $value,
            format: .number,
            placeholder: "Количество",
            keyboardType: .numberPad
        )
        BaseTextField(
            "Value",
            value: .constant(5), // тут крестик работать не будет
            format: .number,
            placeholder: "Количество",
            errorText: "Какая-то ошибка, пока не понятно в чем :)",
            keyboardType: .numberPad
        )
    }
    .padding()
    .background(Color.backgroundScreen)
    .onChange(of: value) { _, newValue in
        print(newValue ?? "none")
    }
}
