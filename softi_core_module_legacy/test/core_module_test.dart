import 'package:flutter_test/flutter_test.dart';

import 'package:softi_core_module/softi_core_module.dart';

void main() {
  test('adds one to input values', () {
    QueryParam q = Filter()
        .$orderBy('name') //
        .$field('valid')
        .$sort(desc: true)
        .$gte(2)
        .$lte(5)
        .$filter$eq('activated', true)
        .$filter$in('status', ['confirmed', 'canceled']) //
        .build();

    expect(q.sortList.length, 2);
    expect(q.sortList[0].desc, false);
    expect(q.sortList[0].field, 'name');
    expect(q.sortList[1].desc, true);
    expect(q.sortList[1].field, 'valid');
    expect(q.filterList.length, 4);
    expect(q.filterList[0].field, 'valid');
    expect(q.filterList[0].condition, QueryOperator.greaterThanOrEqualTo);
    expect(q.filterList[0].value, 2);
    expect(q.filterList[2].field, 'activated');
    expect(q.filterList[2].condition, QueryOperator.equal);
    expect(q.filterList[2].value, true);
  });
}
