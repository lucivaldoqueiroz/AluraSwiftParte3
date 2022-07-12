//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Lucivaldo Queiroz on 14/06/22.
//

import UIKit

protocol AdicionaRefeicaoDelegate{
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    // MARK: - IBoutlet
    
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
//    var itens: [String] = ["Molho de tomate", "Queijo", "Molho apimentado", "Manjericao" ]
    
    var itens:[Item] = []
    var itensSelecionados: [Item] = []
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField:UITextField?
    @IBOutlet var felicidadeTextField:UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        recuperaItens()
    }
    
    func recuperaItens(){
        itens = itemDao().recupera()
    }
    
    @objc func adicionarItens(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itemDao().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibe(mensagem: "Erro ao atualizar tabela")
        } 
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        celula.textLabel?.text = item.nome
        return celula
    }
    
   
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else {
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
                
                // teste:
               // for itemSelecionado in itensSelecionados{
               //     print(itemSelecionado.nome)
              //  }
            }
        }
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        
        guard let nomeDaRefeicao = nomeTextField?.text else {
              return nil
          }

          guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
              return nil
          }

          let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    
    // MARK: - IBActions

   @IBAction func adicionar () {
   
/*
       if let nomeDaRefeicao = nomeTextField?.text, let felicidadeDaRefeicao = felicidadeTextField?.text {
           let nome = nomeDaRefeicao
          if let felicidade = Int(felicidadeDaRefeicao){
               let refeicao = Refeicao(nome: nome, felicidade: felicidade)
               print("Comi \(refeicao.nome) e fiquei com a felicidade: \(refeicao.felicidade)")
          } else {
              print("erro ao tentar criar a refeição")
          }
       }
 */

       //let refeicao = recuperaRefeicaoDoFormulario()
       
 //      guard let refeicao = recuperaRefeicaoDoFormulario() else {
//         return
//      }
       
       if let refeicao = recuperaRefeicaoDoFormulario() {
           delegate?.add(refeicao)
           navigationController?.popViewController(animated: true)
       } else {
           Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulario")
       }
          }
    }

//}
