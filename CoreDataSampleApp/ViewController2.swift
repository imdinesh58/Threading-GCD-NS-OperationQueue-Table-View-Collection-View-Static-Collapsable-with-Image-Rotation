import Foundation
import UIKit

class ViewController2: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var test:[String] = []
    var test2:[String] = []
    var test3:[String] = []
    var test4:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        test.removeAll()
        test2.removeAll()
        test3.removeAll()
        test4.removeAll()
        //var operationQueue = NSOperationQueue()
        //let operation1 : NSBlockOperation = NSBlockOperation ({
            //self.doCalculations()
            //let operation2 : NSBlockOperation = NSBlockOperation ({
                //self.doSomeMoreCalculations()
            //})
            //operationQueue.addOperation(operation2)
        //})
        //operationQueue.addOperation(operation1)
        let queue1 = DispatchQueue(label: "com.knowstack.queue1", qos:.utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        let queue2 = DispatchQueue(label: "com.knowstack.queue1", qos:.utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
        queue1.async {
            let ApiUrl = "http://temp1.pickzy.com/interview_pickzy/interview.json"
            let req = NSMutableURLRequest(url: NSURL(string: ApiUrl)! as URL)
            req.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: req as URLRequest) {
                data, response, error in
                if error != nil {
                    print("error=\(String(describing: error))")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("StatusCode is === \(httpStatus.statusCode)")
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                    let responseString = String(data: data!, encoding: String.Encoding.utf8)
                    print("StatusCode is === \(httpStatus.statusCode)")
                    _ = self.convertStringToDictionary(text: responseString!)
                }
            }
            task.resume()
        }
        queue2.async {
            let ApiUrl = "https://reqres.in/api/users?page=2"
            let req = NSMutableURLRequest(url: NSURL(string: ApiUrl)! as URL)
            req.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: req as URLRequest) {
                data, response, error in
                if error != nil {
                    print("error=\(String(describing: error))")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("StatusCode is === \(httpStatus.statusCode)")
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                    let responseString = String(data: data!, encoding: String.Encoding.utf8)
                    print("StatusCode is === \(httpStatus.statusCode)")
                    _ = self.convertStringToDictionary2(text: responseString!)
                }
            }
            task.resume()
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        DispatchQueue.main.async(){
            if let data = text.data(using: String.Encoding.utf8) {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                    let Arrays = jsonObj["Item"]?["Content"] as! [Dictionary <String,AnyObject>]
                    for key in Arrays {
                        let testd = key["Name"] as! String
                        let testd2 = key["URL"] as! String
                        print("Collection Viuew")
                        print(testd , testd2)
                        self.test2.append(testd)
                        self.test.append(testd2)
                    }
                    self.collectionView.reloadData()
                } catch { }
            }
        }
        return nil
    }
    func convertStringToDictionary2(text: String) -> [String:AnyObject]? {
        DispatchQueue.main.async(){
            if let data = text.data(using: String.Encoding.utf8) {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                    let Arrays = jsonObj["data"] as! [Dictionary <String,AnyObject>]
                    for key in Arrays {
                        let testd = key["avatar"] as! String
                        let testd2 = key["first_name"] as! String
                        print("Table View")
                        print(testd , testd2)
                        self.test3.append(testd)
                        self.test4.append(testd2)
                    }
                    self.tableView.reloadData()
                } catch { }
            }
        }
        return nil
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionCell
        cell.lbl?.text = test2[indexPath.item]
        let data = self.test[indexPath.row]
        let url = URL(string: data)
        if let datass = try? Data(contentsOf: url!)
        {
            let imagess: UIImage = UIImage(data: datass)!
            cell.imgView?.image = imagess
        }
        return cell
    }
}
extension ViewController2: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test3.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as! tableviewCell
        cell.lbl.text = self.test4[indexPath.row]
        let data = self.test3[indexPath.row]
        let url = URL(string: data)
        if let datass = try? Data(contentsOf: url!)
        {
            let imagess: UIImage = UIImage(data: datass)!
            cell.img?.image = imagess
        }
        return cell
    }
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
}
class tableviewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
