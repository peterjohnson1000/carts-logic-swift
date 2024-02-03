struct Product {
  let id: Int 
  var name: String 
  var price: Int 
  var discount: Int 
}

var allProducts = [Product]()

// Add a New Product
func addProduct(_ id: Int,_ name: String,_ price: Int,_ discount: Int) -> Product
{
  return Product(id: id, name: name, price: price, discount: discount)
}

allProducts.append(addProduct(1,"apple",500,0))
allProducts.append(addProduct(2,"banana",200,0))

// String Error Handlind
func stringErrorHandling(_ userInput:String) -> String
{
  if userInput.isEmpty
  {
    return "Product"
  }
  return userInput
}

// Input New Product Details
func inputNewProductDetails() {
  print("\n Please enter the Product Details")
  print("\n -------------------------------- \n")

  // fetching the last product id
  let currentId = allProducts.isEmpty ? 0 : allProducts[allProducts.count - 1].id + 1

  print("Product Name:", terminator:" ")
  var productName = readLine()!
  productName = stringErrorHandling(productName)

  print("Product Price:", terminator:" ")
  let productPrice = Int(readLine() ?? "") ?? 0

  print("Product Discount (Press Enter for 0₹/0%): ", terminator:" ")
  let productDiscount = Int(readLine() ?? "") ?? 0

  print("\n Please Verify the Product Details")
  print("\n -------------------------------- \n")

  print("Product id: \(currentId)")
  print("Product Name: \(productName)")
  print("Product Price: \(productPrice)")
  print("Product Discount: \(productDiscount) \n")

  print("Press Enter to Add the Product / N to cancel the operation")
  let confirmProduct = readLine() ?? "Yes" 

  if confirmProduct == "Yes" || confirmProduct.isEmpty
  {
      allProducts.append(addProduct(currentId,productName,productPrice,productDiscount))
      print(allProducts)
  }
  else
  {
    print("Operation Canceled") 
  }

  print("\n")
}

// edit product details
func editProductDetails() {
  
  func updateStringValue(_ newValue: String, _ toEdit: WritableKeyPath<Product, String>, _ index: Int) -> Bool {
    allProducts[index][keyPath: toEdit] = newValue
    return true
  }
  
  func updateIntValue(_ newValue: Int, _ toEdit: WritableKeyPath<Product, Int>, _ index: Int) -> Bool {
    allProducts[index][keyPath: toEdit] = newValue
    return true
  }

  func displayUpdateValueResponse(_ product: Int)
  {
    print("\n")
    print("Updated!")
    print("Id: \(allProducts[product].id), Name: \(allProducts[product].name), Price: \(allProducts[product].price), Discount: \(allProducts[product].discount) \n")
  }
  
  print("Enter Product Name:", terminator:" ")
  let productName = readLine()!
  var productFound = false
  for product in allProducts
  {
    if product.name == productName
    {
      print("\n")
      print("Id: \(product.id), Name: \(product.name), Price: \(product.price), Discount: \(product.discount) \n")
      productFound = true
      break
    }

    if !productFound
    {
        print("\n")
        print("No product with \(productName) found")
        print("Please try again! \n")
        break
    }
  }

  if productFound
  {
    print("Enter ID of product to edit:", terminator:" ")
    let productID = Int(readLine() ?? "") ?? 0
  
    for product in 0..<allProducts.count
    {
      if allProducts[product].id == productID
      {
        print("\n")
        print("Id: \(allProducts[product].id), Name: \(allProducts[product].name), Price: \(allProducts[product].price), Discount: \(allProducts[product].discount) \n")
        
        print("What do you want to Edit:")
        print("1. Name")
        print("2. Price")
        print("3. Discount")
  
        let choice = Int(readLine()!)!
  
        if choice == 1
        {
          print("Enter new name:", terminator:" ")
  
          let newProductName = readLine() ?? allProducts[product].name
          let updateValueResponse = updateStringValue(newProductName,\.name,product)
          
          if updateValueResponse
          {
            displayUpdateValueResponse(product)
          }
          
          break
        }
        else if choice == 2
        {
          print("Enter new price:", terminator:" ")
          
          let newProductPrice = Int(readLine() ?? "") ?? allProducts[product].price
          let updateValueResponse = updateIntValue(newProductPrice,\.price,product)
  
          if updateValueResponse
          {
            displayUpdateValueResponse(product)
          }
          break
        }
        else
        {
          print("Enter new discount:", terminator:" ")
          print("Enter new price:", terminator:" ")
  
          let newProductDiscount = Int(readLine() ?? "") ?? allProducts[product].price
          let updateValueResponse = updateIntValue(newProductDiscount,\.discount,product)
  
          if updateValueResponse
          {
            displayUpdateValueResponse(product)
          }
          break
        }
      }
    }
  }
}

// View All Products
func viewAllProducts() 
{
  print("\n")
  
  for product in allProducts
  {
    print("Id: \(product.id), Name: \(product.name), Price: \(product.price), Discount: \(product.discount)")
  }
  
  print("\n")
}

// Remove a Product
func deleteProduct() {
  
  print("Enter ID of product to delete:", terminator:" ")
  let productID = Int(readLine() ?? "") ?? 0
  
  for product in 0..<allProducts.count
  {
    if allProducts[product].id == productID
    {
      let index = product
      allProducts.remove(at:index)
      break
    }
  }
}

func searchProduct(_ name: String)
{
  for product in allProducts
  {
    if product.name == name
    {
      print("Id: \(product.id), Name: \(product.name), Price: \(product.price), Discount: \(product.discount)")
      return
    }
  }
  print("\(name) not found :(")
}

// Retailer
while(true)
{
  print("1. Add Product")
  print("2. Delete Product")
  print("3. Edit Product")
  print("4. Search Product")
  print("5. View all Product")
  print("6. Exit \n")

  let choice = Int(readLine()!)

  switch choice
  {
    case 1:
      inputNewProductDetails()

    case 2:
      deleteProduct()
    
    case 3:
      editProductDetails()

    case 5:
      viewAllProducts() 
      
    default:
      print("wroog")
  }
}

var cart = [Product]()
var total: Int = 0

func addToCart()
{
  print("Enter ID of product to Add:", terminator:" ")
  let productID = Int(readLine() ?? "") ?? 0

  for product in allProducts
  {
    if product.id == productID
    {
      cart.append(product)
      total += product.price - product.discount
      print("Current Total = \(total)")
      print("\n")
      return
    }
  }
}

func viewCart()
{
  print("\n")
  print("Cart")
  print("------------")
  for product in cart
  {
    print("ID: \(product.id) Name:\(product.name)")
  }
  print("Total = \(total) \n")
}

func removeFromCart()
{
  print("Enter ID of product to Remove:", terminator:" ")
  let productID = Int(readLine() ?? "") ?? 0
  for product in 0..<cart.count
  {
    if cart[product].id == productID
    {
      total -= cart[product].price
      print(product)
      cart.remove(at: product)
      break
    }
  }
  viewCart()
}

// Customer
while(true)
{
  print("1. Search Product")
  print("2. Add to Cart")
  print("3. Remove from Cart")
  print("4. View Cart")
  print("6. Exit \n")

  let choice = Int(readLine()!)

  switch choice
  {
    case 1:
      print("Enter name to search:")
      let productName = readLine()!
      searchProduct(productName)

    case 2:
      addToCart()

    case 3:
      removeFromCart()
    
    case 4:
      viewCart()

    default:
      print("wroog")
  }
}