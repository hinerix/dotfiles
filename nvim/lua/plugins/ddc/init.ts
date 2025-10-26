import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim/config";
import type { Context, DdcItem } from "jsr:@shougo/ddc-vim/types";

import * as fn from "jsr:@denops/std/function";

export class Config extends BaseConfig {
	override config(args: ConfigArguments): Promise<void> {

		const sources = [
			"lsp",
			"file",
			"around",
			"buffer",
		];

		args.contextBuilder.patchGlobal({
			ui: "pum",
			autoCompleteEvents: [
				"InsertEnter",
				"CmdlineEnter",
				"CmdlineChanged",
				"TextChangedI",
				"TextChangedP",
				"TextChangedT",
			],
			sources: sources,
			cmdlineSources: {
				":": [
					"cmdline",
					"cmdline_history",
					"around",
				],
				"@": [
					"input",
					"cmdline_history",
					"file",
					"around",
				],
				">": [
					"input",
					"cmdline_history",
					"file",
					"around",
				],
				"/": [
					"around",
					"line",
				],
				"?": [
					"around",
					"line",
				],
				"-": [
					"around",
					"line",
				],
				"=": [
					"input",
				],
			},
			sourceOptions: {
				_: {
					ignoreCase: true,
					matchers: [ "matcher_fuzzy" ],
					sorters: [ "sorter_fuzzy" ],
					converters: [ "converter_fuzzy" ],
					timeout: 1000,
				},
				around: { mark: "around" },
				buffer: { mark: "buffer" },
				cmdline: {
					isVolatile: true,
					mark: "cmdline",
					matchers: [ "matcher_fuzzy" ],
					sorters: [ "sorter_fuzzy" ],
					forceCompletionPattern: String.raw`\S/\S*|\.\w*`,
				},
				cmdline_history: {
					mark: "history",
					sorters: [],
				},
				file: {
					mark: "file",
					isVolatile: true,
					forceCompletionPattern: String.raw`\S/\S*`,
				},
				input: {
					mark: "input",
					forceCompletionPattern: String.raw`\S/\S*`,
					isVolatile: true,
					sorters: [ "sorter_fuzzy" ],
				},
				line: {
					mark: "line",
				},
				lsp: {
					mark: "lsp",
					dup: "keep",
					forceCompletionPattern: String.raw`\.\w*|::\w*|->\w*`,
				},
				skkeleton: {
					mark: "skk",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
				skkeleton_okuri: {
					mark: "skk*",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
			},
			sourceParams: {
				around: { maxSize: 500 },
				buffer: {
					requireSameFiletype: false,
					limitBytes: 50000,
					fromAltBuf: true,
					forceCollect: true,
				},
				file: {
					filenameChars: "[:keyword:].",
				},
				lsp: {
					enableAddtionalTextEdit: true,
					enableDisplayDetail: true,
					enableResolveItem: true,
					confirmBehavior: "replace",
				},
			},
		});
		return Promise.resolve();
	}
}
