//
//  Product.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

struct Product: Codable, Equatable {
    var image: String
    var title: String
    var description: String
    var price: String
    var count = 1
}

//var products = [
//    Product(image: "sandwich1", title: "Сэндвич с ветчиной", description: "Ветчина, хлеб, сыр, майонез, салатные листья, момидор, огурец", price: "345 р"),
//    Product(image: "sandwich4", title: "Донер", description: "Лепёшка, фалафель, салат, помидоры, огурцы, красный лук, капуста, соус тахини", price: "375 р"),
//    Product(image: "br1", title: "Скрэмбл", description: "Яйца, молоко, соль, перец, масло, зелень, моцарелла", price: "375 р"),
//    Product(image: "pizza1", title: "Пепперони", description: "Пикантная пепперони, увеличенная порция моцареллы, томаты, фирменный томатный соус", price: "от 625 р"),
//    Product(image: "pizza2", title: "Итальянская", description: "Моцарелла, томаты, свежий базилик, оливковое масло, чеснок, перец чили (опционально), фирменный томатный соус", price: "456 р"),
//    Product(image: "pizza3", title: "Грибы и колбаски", description: "Колбаски, грибы, моцарелла, томатный соус, оливковое масло, кинза", price: "512 р"),
//    Product(image: "pizza4", title: "Вегетарианская", description: "Томаты, лук, перец, оливки, маслины, моцарелла, пармезан, томатный соус", price: "732 р"),
//    Product(image: "pizza5", title: "Мясная", description: "Ветчина, пепперони, салями, бекон, шпинат, лук, моцарелла, сливочный или томатный соус", price: "756 р"),
//    Product(image: "pizza6", title: "Маргарита", description: "Моцарелла, томаты, базилик, оливковое масло, фирменный томатный соус", price: "345 р"),
//    Product(image: "pizza7", title: "Сырная", description: "Моцарелла, пармезан, гауда, чеддер, горгонзола, сливочный сыр, маслины, томатный соус", price: "415 р"),
//    Product(image: "pizza8", title: "Маслины и грибы", description: "Шампиньоны, лисички, оливки, моцарелла, сливочный соус, чеснок, лук", price: "571 р"),
//    Product(image: "pizza9", title: "Венецианская", description: "Перец, моцарелла, шампиньоны, куриная грудка, томаты, фирменный томатный соус, маслины", price: "645 р"),
//    Product(image: "pizza10", title: "Греческая", description: "Фета, оливки, помидоры, лук, оливковое масло, томатный соус, орегано", price: "719 р"),
//    Product(image: "snack1", title: "Картофель фри", description: "Запеченная картошечка с пряными специями", price: "270 р"),
//    Product(image: "snack2", title: "Креветки в кляре", description: "Кляр изумительно хрустящий, креветки сочные и ароматные.", price: "420 р"),
//    Product(image: "snack3", title: "Наггетсы", description: "Хрустящие кусочки куриного мяса, обжаренные до золотистой корочки", price: "382 р"),
//    Product(image: "snack4", title: "Сырные палочки", description: "Нежный сыр моцарелла, обволакивающийся хрустящей корочкой", price: "234 р"),
//    Product(image: "drink1", title: "Американо", description: "Классический напиток с простым, но насыщенным вкусом", price: "98 р"),
//    Product(image: "drink2", title: "Горячий шоколад", description: "Согревающий в холодные дни и поднимающее настроение", price: "130 р"),
//    Product(image: "drink3", title: "Каппучино", description: "Идеальное сочетание крепкого эспрессо и нежной молочной пенки", price: "250 р"),
//    Product(image: "drink4", title: "Чай черный", description: "Насыщенный и ароматный напиток придающий энергию ", price: "99 р"),
//    Product(image: "drink5", title: "Чай зеленый", description: "Освежающий напиток наполненный антиоксидантами", price: "99 р"),
//    Product(image: "dessert1", title: "Пирог", description: "Изысканное сочетание нежного теста и аппетитной начинки", price: "от 180 р"),
//    Product(image: "dessert2", title: "Баноффи", description: "Нежность бисквита, кремовая текстура карамели и ароматный вкус спелых бананов", price: "265 р"),
//    Product(image: "dessert3", title: "Чизкейк", description: "Сливочный десерт с основой из крошечного теста, покрытый сочным фруктовым топпингом", price: "278 р"),
//    Product(image: "dessert4", title: "Печенье", description: " Наслаждение в каждом кусочке", price: "189 р"),
//    Product(image: "sauce1", title: "Томатный соус", description: "Насыщенный вкус и аромат, идеально подходящий к различным блюдам", price: "69 р"),
//    Product(image: "sauce2", title: "Чесночный соус", description: "Интенсивный вкус с нотками ароматного чеснока", price: "69 р"),
//    Product(image: "sauce3", title: "Горчичный соус", description: "Жгучий и ароматный, придающий остроты вашему блюду.", price: "69 р")
//]

