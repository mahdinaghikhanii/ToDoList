import 'package:todolist/data/source/source.dart';

class Repository<T> implements DataSource {
  final DataSource<T> localDataSource;
  Repository(this.localDataSource);
  @override
  Future createOrUpdate(data) {
    return localDataSource.createOrUpdate(data);
  }

  @override
  Future<void> delete(data) {
    return localDataSource.delete(data);
  }

  @override
  Future<void> deleteAll() {
    return localDataSource.deleteAll();
  }

  @override
  Future<void> deleteById(id) {
    return localDataSource.deleteById(id);
  }

  @override
  Future findById(id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }
}
