const std = @import("../std.zig");
const Cpu = std.Target.Cpu;

pub const Feature = enum {
    deflate_conversion,
    dfp_packed_conversion,
    dfp_zoned_conversion,
    distinct_ops,
    enhanced_dat_2,
    enhanced_sort,
    execution_hint,
    fast_serialization,
    fp_extension,
    guarded_storage,
    high_word,
    insert_reference_bits_multiple,
    interlocked_access1,
    load_and_trap,
    load_and_zero_rightmost_byte,
    load_store_on_cond,
    load_store_on_cond_2,
    message_security_assist_extension3,
    message_security_assist_extension4,
    message_security_assist_extension5,
    message_security_assist_extension7,
    message_security_assist_extension8,
    message_security_assist_extension9,
    miscellaneous_extensions,
    miscellaneous_extensions_2,
    miscellaneous_extensions_3,
    population_count,
    processor_assist,
    reset_reference_bits_multiple,
    transactional_execution,
    vector,
    vector_enhancements_1,
    vector_enhancements_2,
    vector_packed_decimal,
    vector_packed_decimal_enhancement,
};

pub usingnamespace Cpu.Feature.feature_set_fns(Feature);

pub const all_features = blk: {
    const len = @typeInfo(Feature).Enum.fields.len;
    std.debug.assert(len <= @typeInfo(Cpu.Feature.Set).Int.bits);
    var result: [len]Cpu.Feature = undefined;
    result[@enumToInt(Feature.deflate_conversion)] = .{
        .index = @enumToInt(Feature.deflate_conversion),
        .name = @tagName(Feature.deflate_conversion),
        .llvm_name = "deflate-conversion",
        .description = "Assume that the deflate-conversion facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.dfp_packed_conversion)] = .{
        .index = @enumToInt(Feature.dfp_packed_conversion),
        .name = @tagName(Feature.dfp_packed_conversion),
        .llvm_name = "dfp-packed-conversion",
        .description = "Assume that the DFP packed-conversion facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.dfp_zoned_conversion)] = .{
        .index = @enumToInt(Feature.dfp_zoned_conversion),
        .name = @tagName(Feature.dfp_zoned_conversion),
        .llvm_name = "dfp-zoned-conversion",
        .description = "Assume that the DFP zoned-conversion facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.distinct_ops)] = .{
        .index = @enumToInt(Feature.distinct_ops),
        .name = @tagName(Feature.distinct_ops),
        .llvm_name = "distinct-ops",
        .description = "Assume that the distinct-operands facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.enhanced_dat_2)] = .{
        .index = @enumToInt(Feature.enhanced_dat_2),
        .name = @tagName(Feature.enhanced_dat_2),
        .llvm_name = "enhanced-dat-2",
        .description = "Assume that the enhanced-DAT facility 2 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.enhanced_sort)] = .{
        .index = @enumToInt(Feature.enhanced_sort),
        .name = @tagName(Feature.enhanced_sort),
        .llvm_name = "enhanced-sort",
        .description = "Assume that the enhanced-sort facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.execution_hint)] = .{
        .index = @enumToInt(Feature.execution_hint),
        .name = @tagName(Feature.execution_hint),
        .llvm_name = "execution-hint",
        .description = "Assume that the execution-hint facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.fast_serialization)] = .{
        .index = @enumToInt(Feature.fast_serialization),
        .name = @tagName(Feature.fast_serialization),
        .llvm_name = "fast-serialization",
        .description = "Assume that the fast-serialization facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.fp_extension)] = .{
        .index = @enumToInt(Feature.fp_extension),
        .name = @tagName(Feature.fp_extension),
        .llvm_name = "fp-extension",
        .description = "Assume that the floating-point extension facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.guarded_storage)] = .{
        .index = @enumToInt(Feature.guarded_storage),
        .name = @tagName(Feature.guarded_storage),
        .llvm_name = "guarded-storage",
        .description = "Assume that the guarded-storage facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.high_word)] = .{
        .index = @enumToInt(Feature.high_word),
        .name = @tagName(Feature.high_word),
        .llvm_name = "high-word",
        .description = "Assume that the high-word facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.insert_reference_bits_multiple)] = .{
        .index = @enumToInt(Feature.insert_reference_bits_multiple),
        .name = @tagName(Feature.insert_reference_bits_multiple),
        .llvm_name = "insert-reference-bits-multiple",
        .description = "Assume that the insert-reference-bits-multiple facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.interlocked_access1)] = .{
        .index = @enumToInt(Feature.interlocked_access1),
        .name = @tagName(Feature.interlocked_access1),
        .llvm_name = "interlocked-access1",
        .description = "Assume that interlocked-access facility 1 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.load_and_trap)] = .{
        .index = @enumToInt(Feature.load_and_trap),
        .name = @tagName(Feature.load_and_trap),
        .llvm_name = "load-and-trap",
        .description = "Assume that the load-and-trap facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.load_and_zero_rightmost_byte)] = .{
        .index = @enumToInt(Feature.load_and_zero_rightmost_byte),
        .name = @tagName(Feature.load_and_zero_rightmost_byte),
        .llvm_name = "load-and-zero-rightmost-byte",
        .description = "Assume that the load-and-zero-rightmost-byte facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.load_store_on_cond)] = .{
        .index = @enumToInt(Feature.load_store_on_cond),
        .name = @tagName(Feature.load_store_on_cond),
        .llvm_name = "load-store-on-cond",
        .description = "Assume that the load/store-on-condition facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.load_store_on_cond_2)] = .{
        .index = @enumToInt(Feature.load_store_on_cond_2),
        .name = @tagName(Feature.load_store_on_cond_2),
        .llvm_name = "load-store-on-cond-2",
        .description = "Assume that the load/store-on-condition facility 2 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension3)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension3),
        .name = @tagName(Feature.message_security_assist_extension3),
        .llvm_name = "message-security-assist-extension3",
        .description = "Assume that the message-security-assist extension facility 3 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension4)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension4),
        .name = @tagName(Feature.message_security_assist_extension4),
        .llvm_name = "message-security-assist-extension4",
        .description = "Assume that the message-security-assist extension facility 4 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension5)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension5),
        .name = @tagName(Feature.message_security_assist_extension5),
        .llvm_name = "message-security-assist-extension5",
        .description = "Assume that the message-security-assist extension facility 5 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension7)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension7),
        .name = @tagName(Feature.message_security_assist_extension7),
        .llvm_name = "message-security-assist-extension7",
        .description = "Assume that the message-security-assist extension facility 7 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension8)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension8),
        .name = @tagName(Feature.message_security_assist_extension8),
        .llvm_name = "message-security-assist-extension8",
        .description = "Assume that the message-security-assist extension facility 8 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.message_security_assist_extension9)] = .{
        .index = @enumToInt(Feature.message_security_assist_extension9),
        .name = @tagName(Feature.message_security_assist_extension9),
        .llvm_name = "message-security-assist-extension9",
        .description = "Assume that the message-security-assist extension facility 9 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.miscellaneous_extensions)] = .{
        .index = @enumToInt(Feature.miscellaneous_extensions),
        .name = @tagName(Feature.miscellaneous_extensions),
        .llvm_name = "miscellaneous-extensions",
        .description = "Assume that the miscellaneous-extensions facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.miscellaneous_extensions_2)] = .{
        .index = @enumToInt(Feature.miscellaneous_extensions_2),
        .name = @tagName(Feature.miscellaneous_extensions_2),
        .llvm_name = "miscellaneous-extensions-2",
        .description = "Assume that the miscellaneous-extensions facility 2 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.miscellaneous_extensions_3)] = .{
        .index = @enumToInt(Feature.miscellaneous_extensions_3),
        .name = @tagName(Feature.miscellaneous_extensions_3),
        .llvm_name = "miscellaneous-extensions-3",
        .description = "Assume that the miscellaneous-extensions facility 3 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.population_count)] = .{
        .index = @enumToInt(Feature.population_count),
        .name = @tagName(Feature.population_count),
        .llvm_name = "population-count",
        .description = "Assume that the population-count facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.processor_assist)] = .{
        .index = @enumToInt(Feature.processor_assist),
        .name = @tagName(Feature.processor_assist),
        .llvm_name = "processor-assist",
        .description = "Assume that the processor-assist facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.reset_reference_bits_multiple)] = .{
        .index = @enumToInt(Feature.reset_reference_bits_multiple),
        .name = @tagName(Feature.reset_reference_bits_multiple),
        .llvm_name = "reset-reference-bits-multiple",
        .description = "Assume that the reset-reference-bits-multiple facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.transactional_execution)] = .{
        .index = @enumToInt(Feature.transactional_execution),
        .name = @tagName(Feature.transactional_execution),
        .llvm_name = "transactional-execution",
        .description = "Assume that the transactional-execution facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.vector)] = .{
        .index = @enumToInt(Feature.vector),
        .name = @tagName(Feature.vector),
        .llvm_name = "vector",
        .description = "Assume that the vectory facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.vector_enhancements_1)] = .{
        .index = @enumToInt(Feature.vector_enhancements_1),
        .name = @tagName(Feature.vector_enhancements_1),
        .llvm_name = "vector-enhancements-1",
        .description = "Assume that the vector enhancements facility 1 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.vector_enhancements_2)] = .{
        .index = @enumToInt(Feature.vector_enhancements_2),
        .name = @tagName(Feature.vector_enhancements_2),
        .llvm_name = "vector-enhancements-2",
        .description = "Assume that the vector enhancements facility 2 is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.vector_packed_decimal)] = .{
        .index = @enumToInt(Feature.vector_packed_decimal),
        .name = @tagName(Feature.vector_packed_decimal),
        .llvm_name = "vector-packed-decimal",
        .description = "Assume that the vector packed decimal facility is installed",
        .dependencies = 0,
    };
    result[@enumToInt(Feature.vector_packed_decimal_enhancement)] = .{
        .index = @enumToInt(Feature.vector_packed_decimal_enhancement),
        .name = @tagName(Feature.vector_packed_decimal_enhancement),
        .llvm_name = "vector-packed-decimal-enhancement",
        .description = "Assume that the vector packed decimal enhancement facility is installed",
        .dependencies = 0,
    };
    break :blk result;
};

pub const cpu = struct {
    pub const arch10 = Cpu{
        .name = "arch10",
        .llvm_name = "arch10",
        .features = featureSet(&[_]Feature{
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_and_trap,
            .load_store_on_cond,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .miscellaneous_extensions,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
        }),
    };
    pub const arch11 = Cpu{
        .name = "arch11",
        .llvm_name = "arch11",
        .features = featureSet(&[_]Feature{
            .dfp_packed_conversion,
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_and_trap,
            .load_and_zero_rightmost_byte,
            .load_store_on_cond,
            .load_store_on_cond_2,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .message_security_assist_extension5,
            .miscellaneous_extensions,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
            .vector,
        }),
    };
    pub const arch12 = Cpu{
        .name = "arch12",
        .llvm_name = "arch12",
        .features = featureSet(&[_]Feature{
            .dfp_packed_conversion,
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .guarded_storage,
            .high_word,
            .insert_reference_bits_multiple,
            .interlocked_access1,
            .load_and_trap,
            .load_and_zero_rightmost_byte,
            .load_store_on_cond,
            .load_store_on_cond_2,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .message_security_assist_extension5,
            .message_security_assist_extension7,
            .message_security_assist_extension8,
            .miscellaneous_extensions,
            .miscellaneous_extensions_2,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
            .vector,
            .vector_enhancements_1,
            .vector_packed_decimal,
        }),
    };
    pub const arch13 = Cpu{
        .name = "arch13",
        .llvm_name = "arch13",
        .features = featureSet(&[_]Feature{
            .deflate_conversion,
            .dfp_packed_conversion,
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .enhanced_sort,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .guarded_storage,
            .high_word,
            .insert_reference_bits_multiple,
            .interlocked_access1,
            .load_and_trap,
            .load_and_zero_rightmost_byte,
            .load_store_on_cond,
            .load_store_on_cond_2,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .message_security_assist_extension5,
            .message_security_assist_extension7,
            .message_security_assist_extension8,
            .message_security_assist_extension9,
            .miscellaneous_extensions,
            .miscellaneous_extensions_2,
            .miscellaneous_extensions_3,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
            .vector,
            .vector_enhancements_1,
            .vector_enhancements_2,
            .vector_packed_decimal,
            .vector_packed_decimal_enhancement,
        }),
    };
    pub const arch8 = Cpu{
        .name = "arch8",
        .llvm_name = "arch8",
        .features = 0,
    };
    pub const arch9 = Cpu{
        .name = "arch9",
        .llvm_name = "arch9",
        .features = featureSet(&[_]Feature{
            .distinct_ops,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_store_on_cond,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .population_count,
            .reset_reference_bits_multiple,
        }),
    };
    pub const generic = Cpu{
        .name = "generic",
        .llvm_name = "generic",
        .features = 0,
    };
    pub const z10 = Cpu{
        .name = "z10",
        .llvm_name = "z10",
        .features = 0,
    };
    pub const z13 = Cpu{
        .name = "z13",
        .llvm_name = "z13",
        .features = featureSet(&[_]Feature{
            .dfp_packed_conversion,
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_and_trap,
            .load_and_zero_rightmost_byte,
            .load_store_on_cond,
            .load_store_on_cond_2,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .message_security_assist_extension5,
            .miscellaneous_extensions,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
            .vector,
        }),
    };
    pub const z14 = Cpu{
        .name = "z14",
        .llvm_name = "z14",
        .features = featureSet(&[_]Feature{
            .dfp_packed_conversion,
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .guarded_storage,
            .high_word,
            .insert_reference_bits_multiple,
            .interlocked_access1,
            .load_and_trap,
            .load_and_zero_rightmost_byte,
            .load_store_on_cond,
            .load_store_on_cond_2,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .message_security_assist_extension5,
            .message_security_assist_extension7,
            .message_security_assist_extension8,
            .miscellaneous_extensions,
            .miscellaneous_extensions_2,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
            .vector,
            .vector_enhancements_1,
            .vector_packed_decimal,
        }),
    };
    pub const z196 = Cpu{
        .name = "z196",
        .llvm_name = "z196",
        .features = featureSet(&[_]Feature{
            .distinct_ops,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_store_on_cond,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .population_count,
            .reset_reference_bits_multiple,
        }),
    };
    pub const zEC12 = Cpu{
        .name = "zEC12",
        .llvm_name = "zEC12",
        .features = featureSet(&[_]Feature{
            .dfp_zoned_conversion,
            .distinct_ops,
            .enhanced_dat_2,
            .execution_hint,
            .fast_serialization,
            .fp_extension,
            .high_word,
            .interlocked_access1,
            .load_and_trap,
            .load_store_on_cond,
            .message_security_assist_extension3,
            .message_security_assist_extension4,
            .miscellaneous_extensions,
            .population_count,
            .processor_assist,
            .reset_reference_bits_multiple,
            .transactional_execution,
        }),
    };
};

/// All systemz CPUs, sorted alphabetically by name.
/// TODO: Replace this with usage of `std.meta.declList`. It does work, but stage1
/// compiler has inefficient memory and CPU usage, affecting build times.
pub const all_cpus = &[_]*const Cpu{
    &cpu.arch10,
    &cpu.arch11,
    &cpu.arch12,
    &cpu.arch13,
    &cpu.arch8,
    &cpu.arch9,
    &cpu.generic,
    &cpu.z10,
    &cpu.z13,
    &cpu.z14,
    &cpu.z196,
    &cpu.zEC12,
};
