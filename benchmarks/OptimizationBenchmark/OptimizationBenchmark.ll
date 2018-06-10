target triple="i686"

@global1 = common global i32 0, align 8
@global2 = common global i32 0, align 8
@global3 = common global i32 0, align 8

define i32 @constantFolding() 
{
.LU1:
	%_retval_ = alloca i32
	%a = alloca i32
	%u0 = mul i32 8, 9
	%u1 = sdiv i32 %u0, 4
	%u2 = add i32 %u1, 2
	%u3 = mul i32 5, 8
	%u4 = sub i32 %u2, %u3
	%u5 = add i32 %u4, 9
	%u6 = sub i32 %u5, 12
	%u7 = add i32 %u6, 6
	%u8 = sub i32 %u7, 9
	%u9 = sub i32 %u8, 18
	%u10 = mul i32 23, 3
	%u11 = sdiv i32 %u10, 23
	%u12 = mul i32 %u11, 90
	%u13 = add i32 %u9, %u12
	store i32 %u13, i32* %a
	%u14 = load i32* %a
	store i32 %u14, i32* %_retval_
	br label %.LU0
.LU0:
	%u15 = load i32* %_retval_
	ret i32 %u15
}

define i32 @constantPropagation() 
{
.LU3:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	%j = alloca i32
	%k = alloca i32
	%l = alloca i32
	%m = alloca i32
	%n = alloca i32
	%o = alloca i32
	%p = alloca i32
	%q = alloca i32
	%r = alloca i32
	%s = alloca i32
	%t = alloca i32
	%u = alloca i32
	%v = alloca i32
	%w = alloca i32
	%x = alloca i32
	%y = alloca i32
	%z = alloca i32
	store i32 4, i32* %a
	store i32 7, i32* %b
	store i32 8, i32* %c
	store i32 5, i32* %d
	store i32 11, i32* %e
	store i32 21, i32* %f
	%u16 = load i32* %a
	%u17 = load i32* %b
	%u18 = add i32 %u16, %u17
	store i32 %u18, i32* %g
	%u19 = load i32* %c
	%u20 = load i32* %d
	%u21 = add i32 %u19, %u20
	store i32 %u21, i32* %h
	%u22 = load i32* %e
	%u23 = load i32* %f
	%u24 = add i32 %u22, %u23
	store i32 %u24, i32* %i
	%u25 = load i32* %g
	%u26 = load i32* %h
	%u27 = add i32 %u25, %u26
	store i32 %u27, i32* %j
	%u28 = load i32* %i
	%u29 = load i32* %j
	%u30 = mul i32 %u28, %u29
	store i32 %u30, i32* %k
	%u31 = load i32* %e
	%u32 = load i32* %h
	%u33 = load i32* %i
	%u34 = mul i32 %u32, %u33
	%u35 = add i32 %u31, %u34
	%u36 = load i32* %k
	%u37 = sub i32 %u35, %u36
	store i32 %u37, i32* %l
	%u38 = load i32* %h
	%u39 = load i32* %i
	%u40 = load i32* %j
	%u41 = mul i32 %u39, %u40
	%u42 = sub i32 %u38, %u41
	%u43 = load i32* %k
	%u44 = load i32* %l
	%u45 = sdiv i32 %u43, %u44
	%u46 = add i32 %u42, %u45
	store i32 %u46, i32* %m
	%u47 = load i32* %e
	%u48 = load i32* %f
	%u49 = add i32 %u47, %u48
	%u50 = load i32* %g
	%u51 = add i32 %u49, %u50
	%u52 = load i32* %h
	%u53 = add i32 %u51, %u52
	%u54 = load i32* %i
	%u55 = add i32 %u53, %u54
	%u56 = load i32* %j
	%u57 = sub i32 %u55, %u56
	store i32 %u57, i32* %n
	%u58 = load i32* %n
	%u59 = load i32* %m
	%u60 = sub i32 %u58, %u59
	%u61 = load i32* %h
	%u62 = add i32 %u60, %u61
	%u63 = load i32* %a
	%u64 = sub i32 %u62, %u63
	%u65 = load i32* %b
	%u66 = sub i32 %u64, %u65
	store i32 %u66, i32* %o
	%u67 = load i32* %k
	%u68 = load i32* %l
	%u69 = add i32 %u67, %u68
	%u70 = load i32* %g
	%u71 = sub i32 %u69, %u70
	%u72 = load i32* %h
	%u73 = sub i32 %u71, %u72
	store i32 %u73, i32* %p
	%u74 = load i32* %b
	%u75 = load i32* %a
	%u76 = sub i32 %u74, %u75
	%u77 = load i32* %d
	%u78 = mul i32 %u76, %u77
	%u79 = load i32* %i
	%u80 = sub i32 %u78, %u79
	store i32 %u80, i32* %q
	%u81 = load i32* %l
	%u82 = load i32* %c
	%u83 = mul i32 %u81, %u82
	%u84 = load i32* %d
	%u85 = mul i32 %u83, %u84
	%u86 = load i32* %o
	%u87 = add i32 %u85, %u86
	store i32 %u87, i32* %r
	%u88 = load i32* %b
	%u89 = load i32* %a
	%u90 = mul i32 %u88, %u89
	%u91 = load i32* %c
	%u92 = mul i32 %u90, %u91
	%u93 = load i32* %e
	%u94 = sdiv i32 %u92, %u93
	%u95 = load i32* %o
	%u96 = sub i32 %u94, %u95
	store i32 %u96, i32* %s
	%u97 = load i32* %i
	%u98 = load i32* %k
	%u99 = add i32 %u97, %u98
	%u100 = load i32* %c
	%u101 = add i32 %u99, %u100
	%u102 = load i32* %p
	%u103 = sub i32 %u101, %u102
	store i32 %u103, i32* %t
	%u104 = load i32* %n
	%u105 = load i32* %o
	%u106 = add i32 %u104, %u105
	%u107 = load i32* %f
	%u108 = load i32* %a
	%u109 = mul i32 %u107, %u108
	%u110 = sub i32 %u106, %u109
	store i32 %u110, i32* %u
	%u111 = load i32* %a
	%u112 = load i32* %b
	%u113 = mul i32 %u111, %u112
	%u114 = load i32* %k
	%u115 = sub i32 %u113, %u114
	%u116 = load i32* %l
	%u117 = sub i32 %u115, %u116
	store i32 %u117, i32* %v
	%u118 = load i32* %v
	%u119 = load i32* %s
	%u120 = sub i32 %u118, %u119
	%u121 = load i32* %r
	%u122 = load i32* %d
	%u123 = mul i32 %u121, %u122
	%u124 = sub i32 %u120, %u123
	store i32 %u124, i32* %w
	%u125 = load i32* %o
	%u126 = load i32* %w
	%u127 = sub i32 %u125, %u126
	%u128 = load i32* %v
	%u129 = sub i32 %u127, %u128
	%u130 = load i32* %n
	%u131 = sub i32 %u129, %u130
	store i32 %u131, i32* %x
	%u132 = load i32* %p
	%u133 = load i32* %x
	%u134 = mul i32 %u132, %u133
	%u135 = load i32* %t
	%u136 = add i32 %u134, %u135
	%u137 = load i32* %w
	%u138 = sub i32 %u136, %u137
	store i32 %u138, i32* %y
	%u139 = load i32* %w
	%u140 = load i32* %x
	%u141 = sub i32 %u139, %u140
	%u142 = load i32* %y
	%u143 = add i32 %u141, %u142
	%u144 = load i32* %k
	%u145 = add i32 %u143, %u144
	store i32 %u145, i32* %z
	%u146 = load i32* %z
	store i32 %u146, i32* %_retval_
	br label %.LU2
.LU2:
	%u147 = load i32* %_retval_
	ret i32 %u147
}

define i32 @deadCodeElimination() 
{
.LU5:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	store i32 4, i32* %a
	store i32 5, i32* %a
	store i32 7, i32* %a
	store i32 8, i32* %a
	store i32 6, i32* %b
	store i32 9, i32* %b
	store i32 12, i32* %b
	store i32 8, i32* %b
	store i32 10, i32* %c
	store i32 13, i32* %c
	store i32 9, i32* %c
	store i32 45, i32* %d
	store i32 12, i32* %d
	store i32 3, i32* %d
	store i32 23, i32* %e
	store i32 10, i32* %e
	store i32 11, i32* @global1
	store i32 5, i32* @global1
	store i32 9, i32* @global1
	%u148 = load i32* %a
	%u149 = load i32* %b
	%u150 = add i32 %u148, %u149
	%u151 = load i32* %c
	%u152 = add i32 %u150, %u151
	%u153 = load i32* %d
	%u154 = add i32 %u152, %u153
	%u155 = load i32* %e
	%u156 = add i32 %u154, %u155
	store i32 %u156, i32* %_retval_
	br label %.LU4
.LU4:
	%u157 = load i32* %_retval_
	ret i32 %u157
}

define i32 @sum(i32 %number) 
{
.LU7:
	%_retval_ = alloca i32
	%_P_number = alloca i32
	store i32 %number, i32* %_P_number
	%total = alloca i32
	store i32 0, i32* %total
	br label %.LU8
.LU8:
	%u158 = load i32* %_P_number
	%u159 = icmp sgt i32 %u158, 0
	br i1 %u159, label %.LU9, label %.LU10
.LU9:
	%u160 = load i32* %total
	%u161 = load i32* %_P_number
	%u162 = add i32 %u160, %u161
	store i32 %u162, i32* %total
	%u163 = load i32* %_P_number
	%u164 = sub i32 %u163, 1
	store i32 %u164, i32* %_P_number
	%u165 = load i32* %_P_number
	%u166 = icmp sgt i32 %u165, 0
	br i1 %u166, label %.LU9, label %.LU10
.LU10:
	%u167 = load i32* %total
	store i32 %u167, i32* %_retval_
	br label %.LU6
.LU6:
	%u168 = load i32* %_retval_
	ret i32 %u168
}

define i32 @doesntModifyGlobals() 
{
.LU12:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	%u169 = load i32* %a
	%u170 = load i32* %b
	%u171 = add i32 %u169, %u170
	store i32 %u171, i32* %_retval_
	br label %.LU11
.LU11:
	%u172 = load i32* %_retval_
	ret i32 %u172
}

define i32 @interProceduralOptimization() 
{
.LU14:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 1, i32* @global1
	store i32 0, i32* @global2
	store i32 0, i32* @global3
	%u173 = call i32 @sum(i32 100)
	store i32 %u173, i32* %a
	br label %.LU15
.LU15:
	%u174 = load i32* @global1
	%u175 = icmp eq i32 %u174, 1
	br i1 %u175, label %.LU16, label %.LU17
.LU16:
	%u176 = call i32 @sum(i32 10000)
	store i32 %u176, i32* %a
	br label %.JN2
.JN2:
	%u183 = load i32* %a
	store i32 %u183, i32* %_retval_
	br label %.LU13
.LU17:
	%u177 = load i32* @global2
	%u178 = icmp eq i32 %u177, 2
	br i1 %u178, label %.LU18, label %.JN0
.LU18:
	%u179 = call i32 @sum(i32 20000)
	store i32 %u179, i32* %a
	br label %.JN0
.JN0:
	br label %.LU19
.LU19:
	%u180 = load i32* @global3
	%u181 = icmp eq i32 %u180, 3
	br i1 %u181, label %.LU20, label %.JN1
.LU20:
	%u182 = call i32 @sum(i32 30000)
	store i32 %u182, i32* %a
	br label %.JN1
.JN1:
	br label %.JN2
.LU13:
	%u184 = load i32* %_retval_
	ret i32 %u184
}

define i32 @commonSubexpressionElimination() 
{
.LU22:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	%j = alloca i32
	%k = alloca i32
	%l = alloca i32
	%m = alloca i32
	%n = alloca i32
	%o = alloca i32
	%p = alloca i32
	%q = alloca i32
	%r = alloca i32
	%s = alloca i32
	%t = alloca i32
	%u = alloca i32
	%v = alloca i32
	%w = alloca i32
	%x = alloca i32
	%y = alloca i32
	%z = alloca i32
	store i32 11, i32* %a
	store i32 22, i32* %b
	store i32 33, i32* %c
	store i32 44, i32* %d
	store i32 55, i32* %e
	store i32 66, i32* %f
	store i32 77, i32* %g
	%u185 = load i32* %a
	%u186 = load i32* %b
	%u187 = mul i32 %u185, %u186
	store i32 %u187, i32* %h
	%u188 = load i32* %c
	%u189 = load i32* %d
	%u190 = sdiv i32 %u188, %u189
	store i32 %u190, i32* %i
	%u191 = load i32* %e
	%u192 = load i32* %f
	%u193 = mul i32 %u191, %u192
	store i32 %u193, i32* %j
	%u194 = load i32* %a
	%u195 = load i32* %b
	%u196 = mul i32 %u194, %u195
	%u197 = load i32* %c
	%u198 = load i32* %d
	%u199 = sdiv i32 %u197, %u198
	%u200 = add i32 %u196, %u199
	%u201 = load i32* %e
	%u202 = load i32* %f
	%u203 = mul i32 %u201, %u202
	%u204 = sub i32 %u200, %u203
	%u205 = load i32* %g
	%u206 = add i32 %u204, %u205
	store i32 %u206, i32* %k
	%u207 = load i32* %a
	%u208 = load i32* %b
	%u209 = mul i32 %u207, %u208
	%u210 = load i32* %c
	%u211 = load i32* %d
	%u212 = sdiv i32 %u210, %u211
	%u213 = add i32 %u209, %u212
	%u214 = load i32* %e
	%u215 = load i32* %f
	%u216 = mul i32 %u214, %u215
	%u217 = sub i32 %u213, %u216
	%u218 = load i32* %g
	%u219 = add i32 %u217, %u218
	store i32 %u219, i32* %l
	%u220 = load i32* %a
	%u221 = load i32* %b
	%u222 = mul i32 %u220, %u221
	%u223 = load i32* %c
	%u224 = load i32* %d
	%u225 = sdiv i32 %u223, %u224
	%u226 = add i32 %u222, %u225
	%u227 = load i32* %e
	%u228 = load i32* %f
	%u229 = mul i32 %u227, %u228
	%u230 = sub i32 %u226, %u229
	%u231 = load i32* %g
	%u232 = add i32 %u230, %u231
	store i32 %u232, i32* %m
	%u233 = load i32* %a
	%u234 = load i32* %b
	%u235 = mul i32 %u233, %u234
	%u236 = load i32* %c
	%u237 = load i32* %d
	%u238 = sdiv i32 %u236, %u237
	%u239 = add i32 %u235, %u238
	%u240 = load i32* %e
	%u241 = load i32* %f
	%u242 = mul i32 %u240, %u241
	%u243 = sub i32 %u239, %u242
	%u244 = load i32* %g
	%u245 = add i32 %u243, %u244
	store i32 %u245, i32* %n
	%u246 = load i32* %a
	%u247 = load i32* %b
	%u248 = mul i32 %u246, %u247
	%u249 = load i32* %c
	%u250 = load i32* %d
	%u251 = sdiv i32 %u249, %u250
	%u252 = add i32 %u248, %u251
	%u253 = load i32* %e
	%u254 = load i32* %f
	%u255 = mul i32 %u253, %u254
	%u256 = sub i32 %u252, %u255
	%u257 = load i32* %g
	%u258 = add i32 %u256, %u257
	store i32 %u258, i32* %o
	%u259 = load i32* %a
	%u260 = load i32* %b
	%u261 = mul i32 %u259, %u260
	%u262 = load i32* %c
	%u263 = load i32* %d
	%u264 = sdiv i32 %u262, %u263
	%u265 = add i32 %u261, %u264
	%u266 = load i32* %e
	%u267 = load i32* %f
	%u268 = mul i32 %u266, %u267
	%u269 = sub i32 %u265, %u268
	%u270 = load i32* %g
	%u271 = add i32 %u269, %u270
	store i32 %u271, i32* %p
	%u272 = load i32* %a
	%u273 = load i32* %b
	%u274 = mul i32 %u272, %u273
	%u275 = load i32* %c
	%u276 = load i32* %d
	%u277 = sdiv i32 %u275, %u276
	%u278 = add i32 %u274, %u277
	%u279 = load i32* %e
	%u280 = load i32* %f
	%u281 = mul i32 %u279, %u280
	%u282 = sub i32 %u278, %u281
	%u283 = load i32* %g
	%u284 = add i32 %u282, %u283
	store i32 %u284, i32* %q
	%u285 = load i32* %a
	%u286 = load i32* %b
	%u287 = mul i32 %u285, %u286
	%u288 = load i32* %c
	%u289 = load i32* %d
	%u290 = sdiv i32 %u288, %u289
	%u291 = add i32 %u287, %u290
	%u292 = load i32* %e
	%u293 = load i32* %f
	%u294 = mul i32 %u292, %u293
	%u295 = sub i32 %u291, %u294
	%u296 = load i32* %g
	%u297 = add i32 %u295, %u296
	store i32 %u297, i32* %r
	%u298 = load i32* %a
	%u299 = load i32* %b
	%u300 = mul i32 %u298, %u299
	%u301 = load i32* %c
	%u302 = load i32* %d
	%u303 = sdiv i32 %u301, %u302
	%u304 = add i32 %u300, %u303
	%u305 = load i32* %e
	%u306 = load i32* %f
	%u307 = mul i32 %u305, %u306
	%u308 = sub i32 %u304, %u307
	%u309 = load i32* %g
	%u310 = add i32 %u308, %u309
	store i32 %u310, i32* %s
	%u311 = load i32* %a
	%u312 = load i32* %b
	%u313 = mul i32 %u311, %u312
	%u314 = load i32* %c
	%u315 = load i32* %d
	%u316 = sdiv i32 %u314, %u315
	%u317 = add i32 %u313, %u316
	%u318 = load i32* %e
	%u319 = load i32* %f
	%u320 = mul i32 %u318, %u319
	%u321 = sub i32 %u317, %u320
	%u322 = load i32* %g
	%u323 = add i32 %u321, %u322
	store i32 %u323, i32* %t
	%u324 = load i32* %a
	%u325 = load i32* %b
	%u326 = mul i32 %u324, %u325
	%u327 = load i32* %c
	%u328 = load i32* %d
	%u329 = sdiv i32 %u327, %u328
	%u330 = add i32 %u326, %u329
	%u331 = load i32* %e
	%u332 = load i32* %f
	%u333 = mul i32 %u331, %u332
	%u334 = sub i32 %u330, %u333
	%u335 = load i32* %g
	%u336 = add i32 %u334, %u335
	store i32 %u336, i32* %u
	%u337 = load i32* %b
	%u338 = load i32* %a
	%u339 = mul i32 %u337, %u338
	%u340 = load i32* %c
	%u341 = load i32* %d
	%u342 = sdiv i32 %u340, %u341
	%u343 = add i32 %u339, %u342
	%u344 = load i32* %e
	%u345 = load i32* %f
	%u346 = mul i32 %u344, %u345
	%u347 = sub i32 %u343, %u346
	%u348 = load i32* %g
	%u349 = add i32 %u347, %u348
	store i32 %u349, i32* %v
	%u350 = load i32* %a
	%u351 = load i32* %b
	%u352 = mul i32 %u350, %u351
	%u353 = load i32* %c
	%u354 = load i32* %d
	%u355 = sdiv i32 %u353, %u354
	%u356 = add i32 %u352, %u355
	%u357 = load i32* %f
	%u358 = load i32* %e
	%u359 = mul i32 %u357, %u358
	%u360 = sub i32 %u356, %u359
	%u361 = load i32* %g
	%u362 = add i32 %u360, %u361
	store i32 %u362, i32* %w
	%u363 = load i32* %g
	%u364 = load i32* %a
	%u365 = load i32* %b
	%u366 = mul i32 %u364, %u365
	%u367 = add i32 %u363, %u366
	%u368 = load i32* %c
	%u369 = load i32* %d
	%u370 = sdiv i32 %u368, %u369
	%u371 = add i32 %u367, %u370
	%u372 = load i32* %e
	%u373 = load i32* %f
	%u374 = mul i32 %u372, %u373
	%u375 = sub i32 %u371, %u374
	store i32 %u375, i32* %x
	%u376 = load i32* %a
	%u377 = load i32* %b
	%u378 = mul i32 %u376, %u377
	%u379 = load i32* %c
	%u380 = load i32* %d
	%u381 = sdiv i32 %u379, %u380
	%u382 = add i32 %u378, %u381
	%u383 = load i32* %e
	%u384 = load i32* %f
	%u385 = mul i32 %u383, %u384
	%u386 = sub i32 %u382, %u385
	%u387 = load i32* %g
	%u388 = add i32 %u386, %u387
	store i32 %u388, i32* %y
	%u389 = load i32* %c
	%u390 = load i32* %d
	%u391 = sdiv i32 %u389, %u390
	%u392 = load i32* %a
	%u393 = load i32* %b
	%u394 = mul i32 %u392, %u393
	%u395 = add i32 %u391, %u394
	%u396 = load i32* %e
	%u397 = load i32* %f
	%u398 = mul i32 %u396, %u397
	%u399 = sub i32 %u395, %u398
	%u400 = load i32* %g
	%u401 = add i32 %u399, %u400
	store i32 %u401, i32* %z
	%u402 = load i32* %a
	%u403 = load i32* %b
	%u404 = add i32 %u402, %u403
	%u405 = load i32* %c
	%u406 = add i32 %u404, %u405
	%u407 = load i32* %d
	%u408 = add i32 %u406, %u407
	%u409 = load i32* %e
	%u410 = add i32 %u408, %u409
	%u411 = load i32* %f
	%u412 = add i32 %u410, %u411
	%u413 = load i32* %g
	%u414 = add i32 %u412, %u413
	%u415 = load i32* %h
	%u416 = add i32 %u414, %u415
	%u417 = load i32* %i
	%u418 = add i32 %u416, %u417
	%u419 = load i32* %j
	%u420 = add i32 %u418, %u419
	%u421 = load i32* %k
	%u422 = add i32 %u420, %u421
	%u423 = load i32* %l
	%u424 = add i32 %u422, %u423
	%u425 = load i32* %m
	%u426 = add i32 %u424, %u425
	%u427 = load i32* %n
	%u428 = add i32 %u426, %u427
	%u429 = load i32* %o
	%u430 = add i32 %u428, %u429
	%u431 = load i32* %p
	%u432 = add i32 %u430, %u431
	%u433 = load i32* %q
	%u434 = add i32 %u432, %u433
	%u435 = load i32* %r
	%u436 = add i32 %u434, %u435
	%u437 = load i32* %s
	%u438 = add i32 %u436, %u437
	%u439 = load i32* %t
	%u440 = add i32 %u438, %u439
	%u441 = load i32* %u
	%u442 = add i32 %u440, %u441
	%u443 = load i32* %v
	%u444 = add i32 %u442, %u443
	%u445 = load i32* %w
	%u446 = add i32 %u444, %u445
	%u447 = load i32* %x
	%u448 = add i32 %u446, %u447
	%u449 = load i32* %y
	%u450 = add i32 %u448, %u449
	%u451 = load i32* %z
	%u452 = add i32 %u450, %u451
	store i32 %u452, i32* %_retval_
	br label %.LU21
.LU21:
	%u453 = load i32* %_retval_
	ret i32 %u453
}

define i32 @hoisting() 
{
.LU24:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	store i32 4, i32* %d
	store i32 0, i32* %i
	br label %.LU25
.LU25:
	%u454 = load i32* %i
	%u455 = icmp slt i32 %u454, 1000000
	br i1 %u455, label %.LU26, label %.LU27
.LU26:
	store i32 5, i32* %e
	%u456 = load i32* %a
	%u457 = load i32* %b
	%u458 = add i32 %u456, %u457
	%u459 = load i32* %c
	%u460 = add i32 %u458, %u459
	store i32 %u460, i32* %g
	%u461 = load i32* %c
	%u462 = load i32* %d
	%u463 = add i32 %u461, %u462
	%u464 = load i32* %g
	%u465 = add i32 %u463, %u464
	store i32 %u465, i32* %h
	%u466 = load i32* %i
	%u467 = add i32 %u466, 1
	store i32 %u467, i32* %i
	%u468 = load i32* %i
	%u469 = icmp slt i32 %u468, 1000000
	br i1 %u469, label %.LU26, label %.LU27
.LU27:
	%u470 = load i32* %b
	store i32 %u470, i32* %_retval_
	br label %.LU23
.LU23:
	%u471 = load i32* %_retval_
	ret i32 %u471
}

define i32 @doubleIf() 
{
.LU29:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	store i32 0, i32* %d
	br label %.LU30
.LU30:
	%u472 = load i32* %a
	%u473 = icmp eq i32 %u472, 1
	br i1 %u473, label %.LU31, label %.JN4
.LU31:
	store i32 20, i32* %b
	br label %.LU32
.LU32:
	%u474 = load i32* %a
	%u475 = icmp eq i32 %u474, 1
	br i1 %u475, label %.LU33, label %.LU34
.LU33:
	store i32 200, i32* %b
	store i32 300, i32* %c
	br label %.JN3
.JN3:
	store i32 50, i32* %d
	br label %.JN4
.JN4:
	%u476 = load i32* %d
	store i32 %u476, i32* %_retval_
	br label %.LU28
.LU34:
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	br label %.JN3
.LU28:
	%u477 = load i32* %_retval_
	ret i32 %u477
}

define i32 @integerDivide() 
{
.LU36:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 3000, i32* %a
	%u478 = load i32* %a
	%u479 = sdiv i32 %u478, 2
	store i32 %u479, i32* %a
	%u480 = load i32* %a
	%u481 = mul i32 %u480, 4
	store i32 %u481, i32* %a
	%u482 = load i32* %a
	%u483 = sdiv i32 %u482, 8
	store i32 %u483, i32* %a
	%u484 = load i32* %a
	%u485 = sdiv i32 %u484, 16
	store i32 %u485, i32* %a
	%u486 = load i32* %a
	%u487 = mul i32 %u486, 32
	store i32 %u487, i32* %a
	%u488 = load i32* %a
	%u489 = sdiv i32 %u488, 64
	store i32 %u489, i32* %a
	%u490 = load i32* %a
	%u491 = mul i32 %u490, 128
	store i32 %u491, i32* %a
	%u492 = load i32* %a
	%u493 = sdiv i32 %u492, 4
	store i32 %u493, i32* %a
	%u494 = load i32* %a
	store i32 %u494, i32* %_retval_
	br label %.LU35
.LU35:
	%u495 = load i32* %_retval_
	ret i32 %u495
}

define i32 @association() 
{
.LU38:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 10, i32* %a
	%u496 = load i32* %a
	%u497 = mul i32 %u496, 2
	store i32 %u497, i32* %a
	%u498 = load i32* %a
	%u499 = sdiv i32 %u498, 2
	store i32 %u499, i32* %a
	%u500 = load i32* %a
	%u501 = mul i32 3, %u500
	store i32 %u501, i32* %a
	%u502 = load i32* %a
	%u503 = sdiv i32 %u502, 3
	store i32 %u503, i32* %a
	%u504 = load i32* %a
	%u505 = mul i32 %u504, 4
	store i32 %u505, i32* %a
	%u506 = load i32* %a
	%u507 = sdiv i32 %u506, 4
	store i32 %u507, i32* %a
	%u508 = load i32* %a
	%u509 = add i32 %u508, 4
	store i32 %u509, i32* %a
	%u510 = load i32* %a
	%u511 = sub i32 %u510, 4
	store i32 %u511, i32* %a
	%u512 = load i32* %a
	%u513 = mul i32 %u512, 50
	store i32 %u513, i32* %a
	%u514 = load i32* %a
	%u515 = sdiv i32 %u514, 50
	store i32 %u515, i32* %a
	%u516 = load i32* %a
	store i32 %u516, i32* %_retval_
	br label %.LU37
.LU37:
	%u517 = load i32* %_retval_
	ret i32 %u517
}

define i32 @tailRecursionHelper(i32 %value, i32 %sum) 
{
.LU40:
	%_retval_ = alloca i32
	%_P_value = alloca i32
	store i32 %value, i32* %_P_value
	%_P_sum = alloca i32
	store i32 %sum, i32* %_P_sum
	br label %.LU41
.LU41:
	%u518 = load i32* %_P_value
	%u519 = icmp eq i32 %u518, 0
	br i1 %u519, label %.LU42, label %.LU43
.LU42:
	%u520 = load i32* %_P_sum
	store i32 %u520, i32* %_retval_
	br label %.LU39
.JN5:
	br label %.LU39
.LU43:
	%u521 = load i32* %_P_value
	%u522 = sub i32 %u521, 1
	%u523 = load i32* %_P_sum
	%u524 = load i32* %_P_value
	%u525 = add i32 %u523, %u524
	%u526 = call i32 @tailRecursionHelper(i32 %u522, i32 %u525)
	store i32 %u526, i32* %_retval_
	br label %.LU39
.LU39:
	%u527 = load i32* %_retval_
	ret i32 %u527
}

define i32 @tailRecursion(i32 %value) 
{
.LU45:
	%_retval_ = alloca i32
	%_P_value = alloca i32
	store i32 %value, i32* %_P_value
	%u528 = load i32* %_P_value
	%u529 = call i32 @tailRecursionHelper(i32 %u528, i32 0)
	store i32 %u529, i32* %_retval_
	br label %.LU44
.LU44:
	%u530 = load i32* %_retval_
	ret i32 %u530
}

define i32 @unswitching() 
{
.LU47:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	br label %.LU48
.LU48:
	%u531 = load i32* %a
	%u532 = icmp slt i32 %u531, 1000000
	br i1 %u532, label %.LU49, label %.LU52
.LU49:
	%u533 = load i32* %b
	%u534 = icmp eq i32 %u533, 2
	br i1 %u534, label %.LU50, label %.LU51
.LU50:
	%u535 = load i32* %a
	%u536 = add i32 %u535, 1
	store i32 %u536, i32* %a
	br label %.JN6
.JN6:
	%u539 = load i32* %a
	%u540 = icmp slt i32 %u539, 1000000
	br i1 %u540, label %.LU49, label %.LU52
.LU51:
	%u537 = load i32* %a
	%u538 = add i32 %u537, 2
	store i32 %u538, i32* %a
	br label %.JN6
.LU52:
	%u541 = load i32* %a
	store i32 %u541, i32* %_retval_
	br label %.LU46
.LU46:
	%u542 = load i32* %_retval_
	ret i32 %u542
}

define i32 @randomCalculation(i32 %number) 
{
.LU54:
	%_retval_ = alloca i32
	%_P_number = alloca i32
	store i32 %number, i32* %_P_number
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%i = alloca i32
	%sum = alloca i32
	store i32 0, i32* %i
	store i32 0, i32* %sum
	br label %.LU55
.LU55:
	%u543 = load i32* %i
	%u544 = load i32* %_P_number
	%u545 = icmp slt i32 %u543, %u544
	br i1 %u545, label %.LU56, label %.LU57
.LU56:
	store i32 4, i32* %a
	store i32 7, i32* %b
	store i32 8, i32* %c
	%u546 = load i32* %a
	%u547 = load i32* %b
	%u548 = add i32 %u546, %u547
	store i32 %u548, i32* %d
	%u549 = load i32* %d
	%u550 = load i32* %c
	%u551 = add i32 %u549, %u550
	store i32 %u551, i32* %e
	%u552 = load i32* %sum
	%u553 = load i32* %e
	%u554 = add i32 %u552, %u553
	store i32 %u554, i32* %sum
	%u555 = load i32* %i
	%u556 = mul i32 %u555, 2
	store i32 %u556, i32* %i
	%u557 = load i32* %i
	%u558 = sdiv i32 %u557, 2
	store i32 %u558, i32* %i
	%u559 = load i32* %i
	%u560 = mul i32 3, %u559
	store i32 %u560, i32* %i
	%u561 = load i32* %i
	%u562 = sdiv i32 %u561, 3
	store i32 %u562, i32* %i
	%u563 = load i32* %i
	%u564 = mul i32 %u563, 4
	store i32 %u564, i32* %i
	%u565 = load i32* %i
	%u566 = sdiv i32 %u565, 4
	store i32 %u566, i32* %i
	%u567 = load i32* %i
	%u568 = add i32 %u567, 1
	store i32 %u568, i32* %i
	%u569 = load i32* %i
	%u570 = load i32* %_P_number
	%u571 = icmp slt i32 %u569, %u570
	br i1 %u571, label %.LU56, label %.LU57
.LU57:
	%u572 = load i32* %sum
	store i32 %u572, i32* %_retval_
	br label %.LU53
.LU53:
	%u573 = load i32* %_retval_
	ret i32 %u573
}

define i32 @iterativeFibonacci(i32 %number) 
{
.LU59:
	%_retval_ = alloca i32
	%_P_number = alloca i32
	store i32 %number, i32* %_P_number
	%previous = alloca i32
	%result = alloca i32
	%count = alloca i32
	%i = alloca i32
	%sum = alloca i32
	store i32 -1, i32* %previous
	store i32 1, i32* %result
	store i32 0, i32* %i
	br label %.LU60
.LU60:
	%u574 = load i32* %i
	%u575 = load i32* %_P_number
	%u576 = icmp slt i32 %u574, %u575
	br i1 %u576, label %.LU61, label %.LU62
.LU61:
	%u577 = load i32* %result
	%u578 = load i32* %previous
	%u579 = add i32 %u577, %u578
	store i32 %u579, i32* %sum
	%u580 = load i32* %result
	store i32 %u580, i32* %previous
	%u581 = load i32* %sum
	store i32 %u581, i32* %result
	%u582 = load i32* %i
	%u583 = add i32 %u582, 1
	store i32 %u583, i32* %i
	%u584 = load i32* %i
	%u585 = load i32* %_P_number
	%u586 = icmp slt i32 %u584, %u585
	br i1 %u586, label %.LU61, label %.LU62
.LU62:
	%u587 = load i32* %result
	store i32 %u587, i32* %_retval_
	br label %.LU58
.LU58:
	%u588 = load i32* %_retval_
	ret i32 %u588
}

define i32 @recursiveFibonacci(i32 %number) 
{
.LU64:
	%_retval_ = alloca i32
	%_P_number = alloca i32
	store i32 %number, i32* %_P_number
	br label %.LU65
.LU65:
	%u589 = load i32* %_P_number
	%u590 = icmp sle i32 %u589, 0
	%u591 = load i32* %_P_number
	%u592 = icmp eq i32 %u591, 1
	%u593 = or i1 %u590, %u592
	br i1 %u593, label %.LU66, label %.LU67
.LU66:
	%u594 = load i32* %_P_number
	store i32 %u594, i32* %_retval_
	br label %.LU63
.JN7:
	br label %.LU63
.LU67:
	%u595 = load i32* %_P_number
	%u596 = sub i32 %u595, 1
	%u597 = call i32 @recursiveFibonacci(i32 %u596)
	%u598 = load i32* %_P_number
	%u599 = sub i32 %u598, 2
	%u600 = call i32 @recursiveFibonacci(i32 %u599)
	%u601 = add i32 %u597, %u600
	store i32 %u601, i32* %_retval_
	br label %.LU63
.LU63:
	%u602 = load i32* %_retval_
	ret i32 %u602
}

define i32 @main() 
{
.LU69:
	%_retval_ = alloca i32
	%input = alloca i32
	%result = alloca i32
	%i = alloca i32
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %input)
	store i32 1, i32* %i
	br label %.LU70
.LU70:
	%u603 = load i32* %i
	%u604 = load i32* %input
	%u605 = icmp slt i32 %u603, %u604
	br i1 %u605, label %.LU71, label %.LU72
.LU71:
	%u606 = call i32 @constantFolding()
	store i32 %u606, i32* %result
	%u607 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u607)
	%u608 = call i32 @constantPropagation()
	store i32 %u608, i32* %result
	%u609 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u609)
	%u610 = call i32 @deadCodeElimination()
	store i32 %u610, i32* %result
	%u611 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u611)
	%u612 = call i32 @interProceduralOptimization()
	store i32 %u612, i32* %result
	%u613 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u613)
	%u614 = call i32 @commonSubexpressionElimination()
	store i32 %u614, i32* %result
	%u615 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u615)
	%u616 = call i32 @hoisting()
	store i32 %u616, i32* %result
	%u617 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u617)
	%u618 = call i32 @doubleIf()
	store i32 %u618, i32* %result
	%u619 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u619)
	%u620 = call i32 @integerDivide()
	store i32 %u620, i32* %result
	%u621 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u621)
	%u622 = call i32 @association()
	store i32 %u622, i32* %result
	%u623 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u623)
	%u624 = load i32* %input
	%u625 = sdiv i32 %u624, 1000
	%u626 = call i32 @tailRecursion(i32 %u625)
	store i32 %u626, i32* %result
	%u627 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u627)
	%u628 = call i32 @unswitching()
	store i32 %u628, i32* %result
	%u629 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u629)
	%u630 = load i32* %input
	%u631 = call i32 @randomCalculation(i32 %u630)
	store i32 %u631, i32* %result
	%u632 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u632)
	%u633 = load i32* %input
	%u634 = sdiv i32 %u633, 5
	%u635 = call i32 @iterativeFibonacci(i32 %u634)
	store i32 %u635, i32* %result
	%u636 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u636)
	%u637 = load i32* %input
	%u638 = sdiv i32 %u637, 1000
	%u639 = call i32 @recursiveFibonacci(i32 %u638)
	store i32 %u639, i32* %result
	%u640 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u640)
	%u641 = load i32* %i
	%u642 = add i32 %u641, 1
	store i32 %u642, i32* %i
	%u643 = load i32* %i
	%u644 = load i32* %input
	%u645 = icmp slt i32 %u643, %u644
	br i1 %u645, label %.LU71, label %.LU72
.LU72:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 9999)
	store i32 0, i32* %_retval_
	br label %.LU68
.LU68:
	%u646 = load i32* %_retval_
	ret i32 %u646
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
