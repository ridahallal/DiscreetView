# DiscreetView
A UIView subclass that blurs itself when a user waves their hand above of the notch (or wherever the ambient light sensor is located).

Inspired by [N26's Discreet Mode](https://n26.com/en-eu/blog/discreet-mode).

## What does it do?
![Demo](Demo.gif)
👆🏼 it does this

## How do I use it?

Add the pod to your Podfile:
```ruby
pod 'DiscreetView'
```

Create an instance of DiscreetView and customise it as you wish:
```swift
private var discreetView: DiscreetView = {
    let discreetView = DiscreetView()
    discreetView.translatesAutoresizingMaskIntoConstraints = false
    discreetView.layer.cornerRadius = Constants.DiscreetViewCornerRadius
    discreetView.backgroundColor = Constants.DiscreetViewBackgroundColor

    return discreetView
}()
```

Put the stuff you want to hide inside the DiscreetView instance:
```swift
private func layoutAmountLabel() {
    discreetView.addSubview(amountLabel)

    NSLayoutConstraint.activate([
        amountLabel.topAnchor.constraint(equalTo: discreetView.topAnchor, constant: Constants.SmallPadding),
        amountLabel.bottomAnchor.constraint(equalTo: discreetView.bottomAnchor, constant: -Constants.SmallPadding),
        amountLabel.leadingAnchor.constraint(equalTo: discreetView.leadingAnchor, constant: Constants.SmallPadding),
        amountLabel.trailingAnchor.constraint(equalTo: discreetView.trailingAnchor, constant: -Constants.SmallPadding)
    ])
}
```

Are you using the DiscreetView inside a UITableViewCell/UICollectionViewCell? Don't forget to update it on reuse:
```swift
override func prepareForReuse() {
    super.prepareForReuse()
        
    discreetView.update()
}
```

Do you plan on tying Discreet Mode to a feature toggle (user defaults for example)?
```swift
// Will allow the DiscreetView instance to listen to changes in the ambient light sensor
discreetView.isActive = true

// Will make the DiscreetView instance stop listening to changes in the ambient light sensor
discreetView.isActive = false

// Replace true and false with the values that come from user defaults or whatever business logic you might have to enable/disable Discreet Mode
```

That's it!