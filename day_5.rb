class Day5

  class << self
    def calc(input)
      commands = input.split("\n")
      commands.map!(&:to_i)

      puts commands.inspect

      current_index = 0

      steps = 0
      while(current_index >= 0 && current_index <= commands.length - 1)

        offset = commands[current_index]
        if offset >= 3
          commands[current_index] -= 1
        else
          commands[current_index] += 1
        end


        current_index = current_index + offset
        steps += 1

      end

      puts steps

    end

  end
end

test_input = "0
3
0
1
-3"
Day5.calc(test_input)
input = "1
0
0
1
0
-3
-3
-6
0
-7
-9
0
-2
0
-8
-1
-15
-15
-4
-12
-19
-3
-12
-10
-3
-17
-17
-9
-18
-20
-1
-6
-29
-18
-5
-25
-13
-22
-33
2
-39
-40
-33
-33
-27
-7
-44
1
-20
-46
-41
0
-19
0
-10
-15
-21
-17
-52
-20
-45
-34
-30
-29
-40
-1
-18
-10
-19
-15
-64
-61
-53
-28
-45
-12
-73
-36
-36
-2
-30
-56
-63
-42
-8
-35
-32
-39
-22
-87
-45
-35
-74
1
-5
-45
-16
-19
-48
-25
-94
-85
-75
-15
-79
-37
-82
-13
-85
-20
-52
-50
-85
-13
-70
-16
-86
0
-68
-55
-15
-25
-31
-117
-91
-67
-114
-108
-50
-76
-116
-12
-27
-98
-115
-101
-124
-2
-4
-95
-41
-35
-110
-86
-4
-126
-67
-94
-81
-101
-93
-109
-71
-152
-110
-145
-28
-139
-106
-83
-58
-100
-1
-21
-112
-130
-102
-34
-80
-49
-11
-72
-82
-132
-36
-119
-127
-85
-66
-12
-43
-3
-86
-116
-125
-162
0
-185
-39
-27
-159
-23
-71
-50
-119
-183
-56
-48
-113
-197
-199
-6
-92
-7
-39
-63
-67
-22
-126
-170
-67
-59
-114
-207
-13
-15
-168
-167
-15
-143
-128
-136
-115
2
-113
-74
-104
-91
-157
-121
-126
-125
-112
-106
-194
-146
-165
-139
-97
-134
-133
-165
-237
-69
-10
-232
-100
-168
-53
-83
-149
-42
-71
-119
-185
-110
-92
-256
-19
-249
-147
-68
-205
-52
-212
-5
-167
-63
-264
-176
-180
-223
-15
-158
-2
-134
-268
-92
-193
-145
-141
-218
-99
-85
-213
-24
-82
-201
-109
0
-152
-14
-168
-103
-232
-7
-115
-141
-273
-117
-201
-165
-265
-81
-64
-243
-123
0
-24
-140
-235
-194
-11
-129
-128
-211
-59
-97
-40
-76
-104
-38
-312
-225
-93
-113
-108
-109
-22
-128
-250
-222
-262
-214
-34
-87
-176
-166
-33
-226
-198
-238
-159
-295
-245
-227
-211
-59
-237
-74
-92
-221
-118
-77
-160
-110
-260
-259
-25
-117
-120
-304
-273
-89
-354
-85
-339
-366
-46
-91
-280
-68
-62
-118
-178
-249
-281
-273
-360
-356
-150
-367
-47
-289
-51
-233
-158
-226
-372
-212
-139
-119
-238
-244
-39
-263
-239
-374
-257
-146
-347
-209
-350
2
-403
-149
-381
-55
-114
-294
-106
-118
-222
-24
-259
-301
-357
-13
-137
-281
-88
-7
-276
2
-7
-232
-337
-172
-181
-129
-51
-147
-310
-253
-396
-111
-386
-106
-240
-432
-94
-239
-334
-135
-196
-329
-228
-10
-438
-419
-86
-167
-56
-200
-69
-229
-90
-147
-160
-345
-7
-96
-251
-113
-53
-186
-426
-244
-185
-178
-267
-378
-368
-53
-424
-178
-179
-353
-242
-182
-423
-139
-49
-335
-225
-3
-13
-159
-245
-244
-359
-223
-380
-264
-383
-285
-322
-471
-7
-295
-84
-291
-92
-129
-175
-205
-49
-164
-262
-105
-364
-438
-283
-415
-323
-167
-501
-22
-428
-10
-156
-517
-385
-356
-396
-295
-372
-409
-311
-261
-262
-4
-41
-264
-436
-316
-22
-449
-444
-306
-324
-16
-431
-379
-476
-369
-198
-312
-393
-47
-277
-523
-402
-368
-312
-418
-21
-372
-86
-286
-475
-183
-405
-427
-404
-405
-446
-549
-296
-249
-243
-472
-450
-126
-260
-227
-25
-348
-122
-80
-330
-222
-389
-360
-250
-310
-544
-113
-556
-445
-457
-533
-447
-251
-373
-343
-391
-12
-567
-128
-332
-245
-252
-517
-101
-480
-401
-290
-394
-321
-533
-257
-102
-152
-251
-102
-507
-597
-175
-345
-442
-600
-306
-149
-151
-355
-71
-315
-35
-161
-404
-253
-526
-275
-339
-483
-315
-423
-116
-345
-507
-332
-27
-395
-634
-548
-205
-276
-213
-356
-413
-353
-89
-88
-649
-465
-580
-286
-607
-21
-35
-227
-415
-501
-343
-245
-94
-200
-376
-43
-585
-668
-623
-264
-574
-223
-628
-556
-100
-53
-88
-644
-285
-631
-418
-369
-477
-379
-199
-68
-323
-337
-318
-651
-255
-323
-38
-502
-356
-550
-555
-679
-170
-38
-516
-367
-687
-52
-23
-225
-451
-323
-637
-264
0
-535
-67
-254
-580
-173
-301
-374
-120
-8
-197
-154
-173
-597
-525
-341
-278
-721
-360
-728
-607
-346
-491
-247
2
-121
-505
-694
-706
-297
-4
-110
-187
-259
-414
-323
-637
-96
-157
-331
-521
-590
-390
-220
-100
-156
-302
-545
-322
-450
-236
-287
-605
-346
-467
-25
-382
-430
-682
2
-261
-605
-635
-633
-553
-491
-226
-622
-191
-48
-92
-218
-548
-651
-672
-631
-764
-367
-108
-507
-790
-573
-282
-334
-280
-285
-105
-797
-228
-85
-102
-623
-304
-52
-278
-243
-681
-133
-606
-345
-354
-402
-6
-353
-447
-69
-432
-54
-486
-78
-774
-241
-625
-806
-425
-790
-381
-507
-755
-304
-362
-606
-256
-25
-341
-451
-12
-606
-738
-484
-167
-663
1
-481
-788
-469
-388
-59
-105
-402
-523
-717
-234
-611
-543
-435
-383
-267
-217
-275
-610
-335
-411
-842
-131
-460
-527
-511
-761
-160
-660
-605
-817
-546
-286
-604
-204
-223
-558
-652
-542
-350
-527
-59
-782
-764
-529
-608
-688
-301
-715
-148
-492
-796
-285
-491
-702
-767
-191
-572
-712
-207
-589
-39
-278
-485
-273
-51
-560
-718
-790
0
-194
-319
-171
-552
-247
-810
-737
-677
-853
-806
-565
-923
-427
-442
-375
-215
-706
-139
-396
-126
-170
-281
-544
-101
-271
-728
-485
-677
-442
-137
-78
-414
-546
-669
-609
-284
-488
-181
-534
-946
-191
-255
-413
-614
-329
-932
-528
-689
-246
-272
-395
-211
-702
-786
-595
-835
-870
-822
-507
-533
-147
-141
-385
-623
-745
-575
-225
-79
-736
-887
-649
-133
-500
-422
-810
-491
-480
-462
-16
-848
-740
-809
-9
-399
-535
-274
-165
-119
-77
-340
-597
-755
-611
-929
-50
-745
-530
-392
-77
-760
-961
-28
-507
-21
-253
-846
-996
-308
-175
-684
-315
-859
-757
-418
-591
-946
-393
-25
-917
-208
-572"

Day5.calc(input)
