const std = @import("std");
const DW = std.dwarf;
const assert = std.debug.assert;
const testing = std.testing;

// zig fmt: off

/// General purpose registers in the AArch64 instruction set
pub const Register = enum(u6) {
    // 64-bit registers
    x0, x1, x2, x3, x4, x5, x6, x7,
    x8, x9, x10, x11, x12, x13, x14, x15,
    x16, x17, x18, x19, x20, x21, x22, x23,
    x24, x25, x26, x27, x28, x29, x30, xzr,

    // 32-bit registers
    w0, w1, w2, w3, w4, w5, w6, w7,
    w8, w9, w10, w11, w12, w13, w14, w15,
    w16, w17, w18, w19, w20, w21, w22, w23,
    w24, w25, w26, w27, w28, w29, w30, wzr,

    pub fn id(self: Register) u5 {
        return @truncate(u5, @enumToInt(self));
    }

    /// Returns the bit-width of the register.
    pub fn size(self: Register) u7 {
        return switch (@enumToInt(self)) {
            0...31 => 64,
            32...63 => 32,
        };
    }

    /// Convert from any register to its 64 bit alias.
    pub fn to64(self: Register) Register {
        return @intToEnum(Register, self.id());
    }

    /// Convert from any register to its 32 bit alias.
    pub fn to32(self: Register) Register {
        return @intToEnum(Register, @as(u6, self.id()) + 32);
    }

    /// Returns the index into `callee_preserved_regs`.
    pub fn allocIndex(self: Register) ?u4 {
        inline for (callee_preserved_regs) |cpreg, i| {
            if (self.id() == cpreg.id()) return i;
        }
        return null;
    }

    pub fn dwarfLocOp(self: Register) u8 {
        return @as(u8, self.id()) + DW.OP_reg0;
    }
};

// zig fmt: on

pub const callee_preserved_regs = [_]Register{
    .x19, .x20, .x21, .x22, .x23,
    .x24, .x25, .x26, .x27, .x28,
};

pub const c_abi_int_param_regs = [_]Register{ .x0, .x1, .x2, .x3, .x4, .x5, .x6, .x7 };
pub const c_abi_int_return_regs = [_]Register{ .x0, .x1 };

test "Register.id" {
    testing.expectEqual(@as(u5, 0), Register.x0.id());
    testing.expectEqual(@as(u5, 0), Register.w0.id());

    testing.expectEqual(@as(u5, 31), Register.xzr.id());
    testing.expectEqual(@as(u5, 31), Register.wzr.id());
}

test "Register.size" {
    testing.expectEqual(@as(u7, 64), Register.x19.size());
    testing.expectEqual(@as(u7, 32), Register.w3.size());
}

test "Register.to64/to32" {
    testing.expectEqual(Register.x0, Register.w0.to64());
    testing.expectEqual(Register.x0, Register.x0.to64());

    testing.expectEqual(Register.w3, Register.w3.to32());
    testing.expectEqual(Register.w3, Register.x3.to32());
}

// zig fmt: off

/// Scalar floating point registers in the aarch64 instruction set
pub const FloatingPointRegister = enum(u8) {
    // 128-bit registers
    q0, q1, q2, q3, q4, q5, q6, q7,
    q8, q9, q10, q11, q12, q13, q14, q15,
    q16, q17, q18, q19, q20, q21, q22, q23,
    q24, q25, q26, q27, q28, q29, q30, q31,

    // 64-bit registers
    d0, d1, d2, d3, d4, d5, d6, d7,
    d8, d9, d10, d11, d12, d13, d14, d15,
    d16, d17, d18, d19, d20, d21, d22, d23,
    d24, d25, d26, d27, d28, d29, d30, d31,

    // 32-bit registers
    s0, s1, s2, s3, s4, s5, s6, s7,
    s8, s9, s10, s11, s12, s13, s14, s15,
    s16, s17, s18, s19, s20, s21, s22, s23,
    s24, s25, s26, s27, s28, s29, s30, s31,

    // 16-bit registers
    h0, h1, h2, h3, h4, h5, h6, h7,
    h8, h9, h10, h11, h12, h13, h14, h15,
    h16, h17, h18, h19, h20, h21, h22, h23,
    h24, h25, h26, h27, h28, h29, h30, h31,

    // 8-bit registers
    b0, b1, b2, b3, b4, b5, b6, b7,
    b8, b9, b10, b11, b12, b13, b14, b15,
    b16, b17, b18, b19, b20, b21, b22, b23,
    b24, b25, b26, b27, b28, b29, b30, b31,

    pub fn id(self: FloatingPointRegister) u5 {
        return @truncate(u5, @enumToInt(self));
    }

    /// Returns the bit-width of the register.
    pub fn size(self: FloatingPointRegister) u8 {
        return switch (@enumToInt(self)) {
            0...31 => 128,
            32...63 => 64,
            64...95 => 32,
            96...127 => 16,
            128...159 => 8,
            else => unreachable,
        };
    }

    /// Convert from any register to its 128 bit alias.
    pub fn to128(self: FloatingPointRegister) FloatingPointRegister {
        return @intToEnum(FloatingPointRegister, self.id());
    }

    /// Convert from any register to its 64 bit alias.
    pub fn to64(self: FloatingPointRegister) FloatingPointRegister {
        return @intToEnum(FloatingPointRegister, @as(u8, self.id()) + 32);
    }

    /// Convert from any register to its 32 bit alias.
    pub fn to32(self: FloatingPointRegister) FloatingPointRegister {
        return @intToEnum(FloatingPointRegister, @as(u8, self.id()) + 64);
    }

    /// Convert from any register to its 16 bit alias.
    pub fn to16(self: FloatingPointRegister) FloatingPointRegister {
        return @intToEnum(FloatingPointRegister, @as(u8, self.id()) + 96);
    }

    /// Convert from any register to its 8 bit alias.
    pub fn to8(self: FloatingPointRegister) FloatingPointRegister {
        return @intToEnum(FloatingPointRegister, @as(u8, self.id()) + 128);
    }
};

// zig fmt: on

test "FloatingPointRegister.id" {
    testing.expectEqual(@as(u5, 0), FloatingPointRegister.b0.id());
    testing.expectEqual(@as(u5, 0), FloatingPointRegister.h0.id());
    testing.expectEqual(@as(u5, 0), FloatingPointRegister.s0.id());
    testing.expectEqual(@as(u5, 0), FloatingPointRegister.d0.id());
    testing.expectEqual(@as(u5, 0), FloatingPointRegister.q0.id());

    testing.expectEqual(@as(u5, 2), FloatingPointRegister.q2.id());
    testing.expectEqual(@as(u5, 31), FloatingPointRegister.d31.id());
}

test "FloatingPointRegister.size" {
    testing.expectEqual(@as(u8, 128), FloatingPointRegister.q1.size());
    testing.expectEqual(@as(u8, 64), FloatingPointRegister.d2.size());
    testing.expectEqual(@as(u8, 32), FloatingPointRegister.s3.size());
    testing.expectEqual(@as(u8, 16), FloatingPointRegister.h4.size());
    testing.expectEqual(@as(u8, 8), FloatingPointRegister.b5.size());
}

test "FloatingPointRegister.toX" {
    testing.expectEqual(FloatingPointRegister.q1, FloatingPointRegister.q1.to128());
    testing.expectEqual(FloatingPointRegister.q2, FloatingPointRegister.b2.to128());
    testing.expectEqual(FloatingPointRegister.q3, FloatingPointRegister.h3.to128());

    testing.expectEqual(FloatingPointRegister.d0, FloatingPointRegister.q0.to64());
    testing.expectEqual(FloatingPointRegister.s1, FloatingPointRegister.d1.to32());
    testing.expectEqual(FloatingPointRegister.h2, FloatingPointRegister.s2.to16());
    testing.expectEqual(FloatingPointRegister.b3, FloatingPointRegister.h3.to8());
}

/// Represents an instruction in the AArch64 instruction set
pub const Instruction = union(enum) {
    MoveWideImmediate: packed struct {
        rd: u5,
        imm16: u16,
        hw: u2,
        fixed: u6 = 0b100101,
        opc: u2,
        sf: u1,
    },
    LoadStoreRegister: packed struct {
        rt: u5,
        rn: u5,
        offset: u12,
        opc: u2,
        op1: u2,
        fixed: u4 = 0b111_0,
        size: u2,
    },
    LoadLiteral: packed struct {
        rt: u5,
        imm19: u19,
        fixed: u6 = 0b011_0_00,
        opc: u2,
    },
    ExceptionGeneration: packed struct {
        ll: u2,
        op2: u3,
        imm16: u16,
        opc: u3,
        fixed: u8 = 0b1101_0100,
    },
    UnconditionalBranchRegister: packed struct {
        op4: u5,
        rn: u5,
        op3: u6,
        op2: u5,
        opc: u4,
        fixed: u7 = 0b1101_011,
    },
    UnconditionalBranchImmediate: packed struct {
        imm26: u26,
        fixed: u5 = 0b00101,
        op: u1,
    },

    pub fn toU32(self: Instruction) u32 {
        return switch (self) {
            .MoveWideImmediate => |v| @bitCast(u32, v),
            .LoadStoreRegister => |v| @bitCast(u32, v),
            .LoadLiteral => |v| @bitCast(u32, v),
            .ExceptionGeneration => |v| @bitCast(u32, v),
            .UnconditionalBranchRegister => |v| @bitCast(u32, v),
            .UnconditionalBranchImmediate => |v| @bitCast(u32, v),
        };
    }

    /// Represents the offset operand of a load or store instruction.
    /// Data can be loaded from memory with either an immediate offset
    /// or an offset that is stored in some register.
    pub const Offset = union(enum) {
        Immediate: union(enum) {
            PostIndex: i9,
            PreIndex: i9,
            Unsigned: u12,
        },
        Register: struct {
            rm: u5,
            shift: union(enum) {
                Uxtw: u2,
                Lsl: u2,
                Sxtw: u2,
                Sxtx: u2,
            },
        },

        pub const none = Offset{
            .Immediate = .{ .Unsigned = 0 },
        };

        pub fn toU12(self: Offset) u12 {
            return switch (self) {
                .Immediate => |imm_type| switch (imm_type) {
                    .PostIndex => |v| (@intCast(u12, @bitCast(u9, v)) << 2) + 1,
                    .PreIndex => |v| (@intCast(u12, @bitCast(u9, v)) << 2) + 3,
                    .Unsigned => |v| v,
                },
                .Register => |r| switch (r.shift) {
                    .Uxtw => |v| (@intCast(u12, r.rm) << 6) + (@intCast(u12, v) << 2) + 16 + 2050,
                    .Lsl => |v| (@intCast(u12, r.rm) << 6) + (@intCast(u12, v) << 2) + 24 + 2050,
                    .Sxtw => |v| (@intCast(u12, r.rm) << 6) + (@intCast(u12, v) << 2) + 48 + 2050,
                    .Sxtx => |v| (@intCast(u12, r.rm) << 6) + (@intCast(u12, v) << 2) + 56 + 2050,
                },
            };
        }

        pub fn imm(offset: u12) Offset {
            return Offset{
                .Immediate = .{ .Unsigned = offset },
            };
        }

        pub fn imm_post_index(offset: i9) Offset {
            return Offset{
                .Immediate = .{ .PostIndex = offset },
            };
        }

        pub fn imm_pre_index(offset: i9) Offset {
            return Offset{
                .Immediate = .{ .PreIndex = offset },
            };
        }

        pub fn reg(rm: Register) Offset {
            return Offset{
                .Register = .{
                    .rm = rm.id(),
                    .shift = .{
                        .Lsl = 0,
                    },
                },
            };
        }

        pub fn reg_uxtw(rm: Register, shift: u2) Offset {
            assert(rm.size() == 32 and (shift == 0 or shift == 2));
            return Offset{
                .Register = .{
                    .rm = rm.id(),
                    .shift = .{
                        .Uxtw = shift,
                    },
                },
            };
        }

        pub fn reg_lsl(rm: Register, shift: u2) Offset {
            assert(rm.size() == 64 and (shift == 0 or shift == 3));
            return Offset{
                .Register = .{
                    .rm = rm.id(),
                    .shift = .{
                        .Lsl = shift,
                    },
                },
            };
        }

        pub fn reg_sxtw(rm: Register, shift: u2) Offset {
            assert(rm.size() == 32 and (shift == 0 or shift == 2));
            return Offset{
                .Register = .{
                    .rm = rm.id(),
                    .shift = .{
                        .Sxtw = shift,
                    },
                },
            };
        }

        pub fn reg_sxtx(rm: Register, shift: u2) Offset {
            assert(rm.size() == 64 and (shift == 0 or shift == 3));
            return Offset{
                .Register = .{
                    .rm = rm.id(),
                    .shift = .{
                        .Sxtx = shift,
                    },
                },
            };
        }
    };

    // Helper functions for assembly syntax functions

    fn moveWideImmediate(
        opc: u2,
        rd: Register,
        imm16: u16,
        shift: u6,
    ) Instruction {
        switch (rd.size()) {
            32 => {
                assert(shift % 16 == 0 and shift <= 16);
                return Instruction{
                    .MoveWideImmediate = .{
                        .rd = rd.id(),
                        .imm16 = imm16,
                        .hw = @intCast(u2, shift / 16),
                        .opc = opc,
                        .sf = 0,
                    },
                };
            },
            64 => {
                assert(shift % 16 == 0 and shift <= 48);
                return Instruction{
                    .MoveWideImmediate = .{
                        .rd = rd.id(),
                        .imm16 = imm16,
                        .hw = @intCast(u2, shift / 16),
                        .opc = opc,
                        .sf = 1,
                    },
                };
            },
            else => unreachable, // unexpected register size
        }
    }

    fn loadStoreRegister(rt: Register, rn: Register, offset: Offset, load: bool) Instruction {
        const off = offset.toU12();
        const op1: u2 = blk: {
            switch (offset) {
                .Immediate => |imm| switch (imm) {
                    .Unsigned => break :blk 0b01,
                    else => {},
                },
                else => {},
            }
            break :blk 0b00;
        };
        const opc: u2 = if (load) 0b01 else 0b00;
        switch (rt.size()) {
            32 => {
                return Instruction{
                    .LoadStoreRegister = .{
                        .rt = rt.id(),
                        .rn = rn.id(),
                        .offset = offset.toU12(),
                        .opc = opc,
                        .op1 = op1,
                        .size = 0b10,
                    },
                };
            },
            64 => {
                return Instruction{
                    .LoadStoreRegister = .{
                        .rt = rt.id(),
                        .rn = rn.id(),
                        .offset = offset.toU12(),
                        .opc = opc,
                        .op1 = op1,
                        .size = 0b11,
                    },
                };
            },
            else => unreachable, // unexpected register size
        }
    }

    fn loadLiteral(rt: Register, imm19: u19) Instruction {
        switch (rt.size()) {
            32 => {
                return Instruction{
                    .LoadLiteral = .{
                        .rt = rt.id(),
                        .imm19 = imm19,
                        .opc = 0b00,
                    },
                };
            },
            64 => {
                return Instruction{
                    .LoadLiteral = .{
                        .rt = rt.id(),
                        .imm19 = imm19,
                        .opc = 0b01,
                    },
                };
            },
            else => unreachable, // unexpected register size
        }
    }

    fn exceptionGeneration(
        opc: u3,
        op2: u3,
        ll: u2,
        imm16: u16,
    ) Instruction {
        return Instruction{
            .ExceptionGeneration = .{
                .ll = ll,
                .op2 = op2,
                .imm16 = imm16,
                .opc = opc,
            },
        };
    }

    fn unconditionalBranchRegister(
        opc: u4,
        op2: u5,
        op3: u6,
        rn: Register,
        op4: u5,
    ) Instruction {
        assert(rn.size() == 64);

        return Instruction{
            .UnconditionalBranchRegister = .{
                .op4 = op4,
                .rn = rn.id(),
                .op3 = op3,
                .op2 = op2,
                .opc = opc,
            },
        };
    }

    fn unconditionalBranchImmediate(
        op: u1,
        offset: i28,
    ) Instruction {
        return Instruction{
            .UnconditionalBranchImmediate = .{
                .imm26 = @bitCast(u26, @intCast(i26, offset >> 2)),
                .op = op,
            },
        };
    }

    // Move wide (immediate)

    pub fn movn(rd: Register, imm16: u16, shift: u6) Instruction {
        return moveWideImmediate(0b00, rd, imm16, shift);
    }

    pub fn movz(rd: Register, imm16: u16, shift: u6) Instruction {
        return moveWideImmediate(0b10, rd, imm16, shift);
    }

    pub fn movk(rd: Register, imm16: u16, shift: u6) Instruction {
        return moveWideImmediate(0b11, rd, imm16, shift);
    }

    // Load or store register

    pub const LdrArgs = struct {
        rn: ?Register = null,
        offset: Offset = Offset.none,
        literal: ?u19 = null,
    };
    pub fn ldr(rt: Register, args: LdrArgs) Instruction {
        if (args.rn) |rn| {
            return loadStoreRegister(rt, rn, args.offset, true);
        } else {
            return loadLiteral(rt, args.literal.?);
        }
    }

    pub const StrArgs = struct {
        offset: Offset = Offset.none,
    };
    pub fn str(rt: Register, rn: Register, args: StrArgs) Instruction {
        return loadStoreRegister(rt, rn, args.offset, false);
    }

    // Exception generation

    pub fn svc(imm16: u16) Instruction {
        return exceptionGeneration(0b000, 0b000, 0b01, imm16);
    }

    pub fn hvc(imm16: u16) Instruction {
        return exceptionGeneration(0b000, 0b000, 0b10, imm16);
    }

    pub fn smc(imm16: u16) Instruction {
        return exceptionGeneration(0b000, 0b000, 0b11, imm16);
    }

    pub fn brk(imm16: u16) Instruction {
        return exceptionGeneration(0b001, 0b000, 0b00, imm16);
    }

    pub fn hlt(imm16: u16) Instruction {
        return exceptionGeneration(0b010, 0b000, 0b00, imm16);
    }

    // Unconditional branch (register)

    pub fn br(rn: Register) Instruction {
        return unconditionalBranchRegister(0b0000, 0b11111, 0b000000, rn, 0b00000);
    }

    pub fn blr(rn: Register) Instruction {
        return unconditionalBranchRegister(0b0001, 0b11111, 0b000000, rn, 0b00000);
    }

    pub fn ret(rn: ?Register) Instruction {
        return unconditionalBranchRegister(0b0010, 0b11111, 0b000000, rn orelse .x30, 0b00000);
    }

    // Unconditional branch (immediate)

    pub fn b(offset: i28) Instruction {
        return unconditionalBranchImmediate(0, offset);
    }

    pub fn bl(offset: i28) Instruction {
        return unconditionalBranchImmediate(1, offset);
    }
};

test "" {
    testing.refAllDecls(@This());
}

test "serialize instructions" {
    const Testcase = struct {
        inst: Instruction,
        expected: u32,
    };

    const testcases = [_]Testcase{
        .{ // movz x1 #4
            .inst = Instruction.movz(.x1, 4, 0),
            .expected = 0b1_10_100101_00_0000000000000100_00001,
        },
        .{ // movz x1, #4, lsl 16
            .inst = Instruction.movz(.x1, 4, 16),
            .expected = 0b1_10_100101_01_0000000000000100_00001,
        },
        .{ // movz x1, #4, lsl 32
            .inst = Instruction.movz(.x1, 4, 32),
            .expected = 0b1_10_100101_10_0000000000000100_00001,
        },
        .{ // movz x1, #4, lsl 48
            .inst = Instruction.movz(.x1, 4, 48),
            .expected = 0b1_10_100101_11_0000000000000100_00001,
        },
        .{ // movz w1, #4
            .inst = Instruction.movz(.w1, 4, 0),
            .expected = 0b0_10_100101_00_0000000000000100_00001,
        },
        .{ // movz w1, #4, lsl 16
            .inst = Instruction.movz(.w1, 4, 16),
            .expected = 0b0_10_100101_01_0000000000000100_00001,
        },
        .{ // svc #0
            .inst = Instruction.svc(0),
            .expected = 0b1101_0100_000_0000000000000000_00001,
        },
        .{ // svc #0x80 ; typical on Darwin
            .inst = Instruction.svc(0x80),
            .expected = 0b1101_0100_000_0000000010000000_00001,
        },
        .{ // ret
            .inst = Instruction.ret(null),
            .expected = 0b1101_011_00_10_11111_0000_00_11110_00000,
        },
        .{ // bl #0x10
            .inst = Instruction.bl(0x10),
            .expected = 0b1_00101_00_0000_0000_0000_0000_0000_0100,
        },
        .{ // ldr x2, [x1]
            .inst = Instruction.ldr(.x2, .{ .rn = .x1 }),
            .expected = 0b11_111_0_01_01_000000000000_00001_00010,
        },
        .{ // ldr x2, [x1, #1]!
            .inst = Instruction.ldr(.x2, .{ .rn = .x1, .offset = Instruction.Offset.imm_pre_index(1) }),
            .expected = 0b11_111_0_00_01_0_000000001_11_00001_00010,
        },
        .{ // ldr x2, [x1], #-1
            .inst = Instruction.ldr(.x2, .{ .rn = .x1, .offset = Instruction.Offset.imm_post_index(-1) }),
            .expected = 0b11_111_0_00_01_0_111111111_01_00001_00010,
        },
        .{ // ldr x2, [x1], (x3)
            .inst = Instruction.ldr(.x2, .{ .rn = .x1, .offset = Instruction.Offset.reg(.x3) }),
            .expected = 0b11_111_0_00_01_1_00011_011_0_10_00001_00010,
        },
        .{ // ldr x2, label
            .inst = Instruction.ldr(.x2, .{ .literal = 0x1 }),
            .expected = 0b01_011_0_00_0000000000000000001_00010,
        },
        .{ // str x2, [x1]
            .inst = Instruction.str(.x2, .x1, .{}),
            .expected = 0b11_111_0_01_00_000000000000_00001_00010,
        },
        .{ // str x2, [x1], (x3)
            .inst = Instruction.str(.x2, .x1, .{ .offset = Instruction.Offset.reg(.x3) }),
            .expected = 0b11_111_0_00_00_1_00011_011_0_10_00001_00010,
        },
    };

    for (testcases) |case| {
        const actual = case.inst.toU32();
        testing.expectEqual(case.expected, actual);
    }
}
