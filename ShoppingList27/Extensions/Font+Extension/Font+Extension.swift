//
//  Font+Extension.swift
//  ShoppingList27
//
//  Created by Kira on 10.09.2025.
//

import SwiftUI

extension Font {
    
    enum Headline {
        /// Начать
        /// Создать список
        /// Создать
        /// Редактировать список
        /// Сохранить
        /// Установить тему (если выбрали)
        /// Удаление списка
        /// Удалить
        /// Новый год (тайтл просмотра товаров)
        /// Добавить товар
        /// Создание товара
        /// Готово
        /// Редактировать
        /// Удаление купленных товаров (подтверждение удаления)
        /// Удаление товара
        static var medium: Font {
            Font.system(size: 17, weight: .medium)
        }
    }
    
    enum Body {
        /// Создавайте списки и не переживайте о покупках
        /// Создайте свой первый список
        /// Введите название списка
        /// Установить тему (если не выбрали)
        /// Сортировать по Алфавиту
        /// Светлая / Темная / Системная
        /// Отменить
        /// Поиск
        /// Начните добавлять товары
        /// Название списка
        /// Количество
        /// Ед.изм.:
        /// шт / кг / г / л / мл
        /// текст 2 шт. (добавленный товар)
        /// Поделиться
        /// Снять отметки со всех товаров
        /// Удалить купленные товары
        static var regular: Font {
            Font.system(size: 17, weight: .regular)
        }
    }
    
    enum LargeTitle {
        /// Добро пожаловать!
        static var regular: Font {
            Font.system(size: 34, weight: .regular)
        }
    }
    
    enum Title1 {
        /// Мои списки
        static var semiBold: Font {
            Font.system(size: 28, weight: .semibold)
        }
    }
    
    enum Title2 {
        /// Никогда не забывайте, что нужно купить
        static var semiBold: Font {
            Font.system(size: 22, weight: .semibold)
        }
    }
    
    enum Title3 {
        /// Давайте спланируем покупки!
        /// Новый год / Кошке / Вечеринка малого
        /// Давайте спланируем покупки!
        static var medium: Font {
            Font.system(size: 20, weight: .medium)
        }
    }
    
    enum Callout {
        /// Выберите цвет
        /// Выберите дизайн
        static var regular: Font {
            Font.system(size: 16, weight: .regular)
        }
    }
    
    enum Footnote {
        /// Это название уже используется, пожалуйста, измените его.
        /// Вы действительно хотите удалить список?
        /// Этот товар уже есть в списке, добавьте другой
        /// Вы действительно хотите удалить все купленные товары?
        /// Вы действительно хотите удалить товар?
        static var regular: Font {
            Font.system(size: 13, weight: .regular)
        }
    }
}
