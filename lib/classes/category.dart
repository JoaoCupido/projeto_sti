final animalCategories = ['Cão', 'Gato', 'Peixe', 'Ave', 'Outros'];

class Category {
  final String imageUrl;
  final String name;

  const Category({
    required this.imageUrl,
    required this.name,
  });
}

final categories = [
  const Category(
    imageUrl: 'assets/images/category/ImagemAlimentos.svg',
    name: 'Alimentos',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemAcessorios.svg',
    name: 'Acessórios',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemBrinquedos.svg',
    name: 'Brinquedos',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemMobiliario.png',
    name: 'Mobiliário',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemVestuario.svg',
    name: 'Vestuário',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemEscovacao.png',
    name: 'Escovação',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemHigiene.png',
    name: 'Higiene',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemViagens.svg',
    name: 'Viagens',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemCasas.svg',
    name: 'Casotas',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemSaude.png',
    name: 'Saúde',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemHidratacao.png',
    name: 'Hidratação',
  ),
  const Category(
    imageUrl: 'assets/images/category/ImagemDejetos.svg',
    name: 'Dejetos',
  ),
];