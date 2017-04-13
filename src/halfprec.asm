; ── ── ── ── ── ██ ██ ██ ██ ██ ██ ── ── ── ── ──
; ── ── ── ██ ██ ██ ▓▓ ░░ ░░ ▓▓ ██ ██ ██ ── ── ──
; ── ── ██ ██ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ██ ██ ── ──
; ── ██ ██ ░░ ▓▓ ▓▓ ░░ ░░ ░░ ░░ ▓▓ ▓▓ ░░ ██ ██ ──
; ── ██ ▓▓ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ▓▓ ██ ──
; ██ ██ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ██ ██
; ██ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ██
; ██ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ██
; ██ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ██
; ██ ░░ ░░ ░░ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ░░ ░░ ░░ ██
; ██ ░░ ░░ ██ ██ ██ ██ ██ ██ ██ ██ ██ ██ ░░ ░░ ██
; ██ ██ ██ ██ ░░ ░░ ██ ░░ ░░ ██ ░░ ░░ ██ ██ ██ ██
; ── ██ ██ ░░ ░░ ░░ ██ ░░ ░░ ██ ░░ ░░ ░░ ██ ██ ──
; ── ── ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ██ ── ──
; ── ── ██ ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ██ ██ ── ──
; ── ── ── ██ ██ ██ ██ ██ ██ ██ ██ ██ ██ ── ── ── halfprec

global half2float
global float2half


SECTION .text

half2float:
  push rbp
  mov rbp, rsp
  mov qword [rbp-18H], rdi
  mov qword [rbp-20H], rsi
  mov dword [rbp-24H], edx
  mov dword [rbp-4H], 0
  jmp L4

float2half:
  push rbp
  mov rbp, rsp
  mov qword [rbp-28H], rdi
  mov qword [rbp-30H], rsi
  mov dword [rbp-34H], edx
  mov dword [rbp-4H], 0
  jmp L12

L1:
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-20H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 7FFFH
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-20H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 8000H
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-20H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 7C00H
  mov dword [rbp-10H], eax
  shl dword [rbp-8H], 13
  shl dword [rbp-0CH], 16
  add dword [rbp-8H], 939524096
  cmp dword [rbp-10H], 0
  jz L2
  mov eax, dword [rbp-8H]
  jmp L3

L2:
  mov eax, 0

L3:
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-0CH]
  or dword [rbp-8H], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax*4]
  mov rax, qword [rbp-18H]
  add rdx, rax
  mov eax, dword [rbp-8H]
  mov dword [rdx], eax
  add dword [rbp-4H], 1

L4:
  mov eax, dword [rbp-4H]
  cmp eax, dword [rbp-24H]
  jl L1
  pop rbp
  ret

L5:
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax*4]
  mov rax, qword [rbp-30H]
  add rax, rdx
  mov eax, dword [rax]
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-8H]
  and eax, 7FFFFFFFH
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-8H]
  and eax, 80000000H
  mov dword [rbp-10H], eax
  mov eax, dword [rbp-8H]
  and eax, 7F800000H
  mov dword [rbp-14H], eax
  shr dword [rbp-0CH], 13
  shr dword [rbp-10H], 16
  sub dword [rbp-0CH], 114688
  cmp dword [rbp-14H], 947912703
  jbe L6
  mov eax, dword [rbp-0CH]
  jmp L7

L6:
  mov eax, 0

L7:
  mov dword [rbp-0CH], eax
  cmp dword [rbp-14H], 1191182336
  ja L8
  mov eax, dword [rbp-0CH]
  jmp L9

L8:
  mov eax, 31743

L9:
  mov dword [rbp-0CH], eax
  cmp dword [rbp-14H], 0
  jz L10
  mov eax, dword [rbp-0CH]
  jmp L11

L10:
  mov eax, 0

L11:
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-10H]
  or dword [rbp-0CH], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-28H]
  add rdx, rax
  mov eax, dword [rbp-0CH]
  mov word [rdx], ax
  add dword [rbp-4H], 1

L12:
  mov eax, dword [rbp-4H]
  cmp eax, dword [rbp-34H]
  jl L5
  pop rbp
  ret
