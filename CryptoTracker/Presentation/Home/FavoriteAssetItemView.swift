//
//  FavoriteAssetItemView.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

struct FavoriteAssetItemView: View {
    @ObservedObject var viewModel: FavoriteAssetItemViewModel
    let getFormatter: (_ price: Decimal) -> NumberFormatter
    let percentageFormatter: NumberFormatter
    
    private var model: CoinAsset { viewModel.model }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            CachedAsyncImageView(url: model.image.flatMap(URL.init)) { image in
                image
                    .resizable()
                    .frame(width: 35, height: 35)
            } placeholder: {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color(.darkPrimary))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(model.symbol.uppercased())
                    .foregroundStyle(.darkPrimary)
                    .font(.system(size: 14).weight(.bold))
                    .accessibilityIdentifier("SymbolLabel")
                Text(model.name)
                    .foregroundStyle(Color(.gray))
                    .font(.system(size: 14))
            }
            .lineLimit(1)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                if let price = model.currentPrice {
                    Text(price.nsValue, formatter: getFormatter(price))
                        .foregroundStyle(priceColor)
                        .animation(.easeInOut(duration: 1), value: viewModel.isPositivePriceChange)
                } else {
                    Text("Unknown $")
                        .foregroundStyle(Color(.darkPrimary))
                }
                   
                if let percentChange = model.pricePercentageChange {
                    Text(percentChange.nsValue, formatter: percentageFormatter)
                        .foregroundStyle(percentChange >= 0 ? Color.green : Color.red)
                }
            }
            .font(.system(size: 12, design: .monospaced).weight(.bold))
            .lineLimit(1)
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: Color(.darkPrimary).opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 8)
        .listRowBackground(Color(.backgroundPrimary))
    }
    
    private var priceColor: Color {
        switch viewModel.isPositivePriceChange {
            case true:
                Color(.green)
            case false:
                Color(.red)
            default:
                Color(.darkPrimary)
        }
    }
}

#Preview {
    FavoriteAssetItemView(viewModel: FavoriteAssetItemViewModel(model: CoinAsset(id: "id", name: "Bitco sdfsdf sdf sdf sd fsdfkkk", symbol: "BTC", marketCapRank: 1, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png", currentPrice: 4.55, priceChange24hPercentage: -1.539, isFavorite: true)), getFormatter: { price in
        let smallPriceFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 4
            formatter.minimumFractionDigits = 4
            formatter.decimalSeparator = "."
            formatter.roundingMode = .down
            return formatter
        }()
        
        let priceFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.decimalSeparator = "."
            formatter.roundingMode = .down
            return formatter
        }()
        if price < 10 {
            return smallPriceFormatter
        } else {
            return priceFormatter
        }
    }, percentageFormatter: {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        formatter.negativePrefix = "-"
        formatter.negativeSuffix = "%"
        formatter.positivePrefix = "+"
        formatter.positiveSuffix = "%"
        return formatter
    }())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .background(Color(.itemBackground))
}
